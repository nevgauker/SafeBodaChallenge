//
//  LufthansaAPI.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 25/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit
import Alamofire
final class LufthansaAPI: NSObject {
    
    static let shared = LufthansaAPI()
    
    private var defaultHeaders = ["Authorization" : "",
                          "Accept" : "application/json",
                          "Content-Type" : "application/json",
                          "Lang" : "EN"]
    
    private let numberOfResults = 40
    
    private let baseUrlStr = "https://api.lufthansa.com/v1/"
    
    private override init() { }
    
    
    func needToFetchToken()->Bool {
        return defaultHeaders["Authorization"] == ""
    }
    func setToken(token:String) {
        self.defaultHeaders["Authorization"] = "Bearer " + token
    }
    
    func fetchToken(completion: @escaping (_ error:String?,_ success:Bool) -> ()){
        let urlString = baseUrlStr + "oauth/token"
        
        let parameters: Parameters = ["client_id": "zxgk2qyz6dtw8u9dpnd8nx5w",
                                      "client_secret" : "3YB8SHvvCd",
                                      "grant_type" : "client_credentials"]
        
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [ "Content-Type" : "application/x-www-form-urlencoded" ])
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                
                print("aaaaa")
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
                if let dict = response.result.value as? Dictionary<String,AnyObject>{
                    
                    print(dict)
                    let token:String =  dict["access_token"] as! String
                    _ = Utils.saveToken(token: token)
                    self.defaultHeaders["Authorization"] = "Bearer " + token
                    let unixTimestamp:TimeInterval = dict["expires_in"] as! TimeInterval
                    let date = Date(timeIntervalSince1970: unixTimestamp)
                    print(date)
                    completion(nil,true)
                }
        }
    }
    
    func fetchCities(index:Int,
                     completion: @escaping (_ error:String?, _ cities : [City]?) -> ()){
        
        let urlString = baseUrlStr + "mds-references/cities"
        
        let parameters = ["limit" : numberOfResults, "offset" : index ]
        
        Alamofire.request(urlString, method: .get, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: defaultHeaders)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                if let dict = response.result.value as? Dictionary<String,AnyObject>{
                    if let citiesData = self.handleCityRespose(dict: dict) {
                        var arr:[City] = [City]()
                        for data in citiesData {
                            let city:City = City(data: data)
                            arr.append(city)
                        }
                        completion(nil,arr)
                    }else {
                        completion(response.error?.localizedDescription,nil)
                    }
                }else {
                    completion(response.error?.localizedDescription,nil)
                }
        }
    }
    
    func fetchAirports(index:Int,airportCode:String?,
                       completion: @escaping (_ error:String?,_ success:Bool) -> ()){
        
        var urlString = baseUrlStr + "mds-references/airports"
        
        let parameters = ["limit" : numberOfResults, "offset" : index ]
        if let code = airportCode {
            urlString += "/\(code)"
        }
        
        Alamofire.request(urlString, method: .get, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: defaultHeaders)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                if let dict = response.result.value as? Dictionary<String,AnyObject>{
                    if let airportsData = self.handleAirportRespose(dict: dict) {
                        AppData.shared.handleAirportsData(data: airportsData)
                         completion(nil,true)
                    }else {
                         completion(response.error?.localizedDescription,false)
                    }
                }else {
                    completion(response.error?.localizedDescription,false)
                }
        }
    }
    
    private func handleAirportRespose(dict:[String : Any])->[[String : Any]]?{
            if let airportResource = dict["AirportResource"]  as? [String : Any]{
                if let airports = airportResource["Airports"]  as? [String : Any]{
                    if let airport = airports["Airport"] as? [[String : Any]] {
                        return airport
                    }
                }
            }
        return nil
    }
    
    private func handleCityRespose(dict:[String : Any])->[[String : Any]]?{
        if let cityResource = dict["CityResource"]  as? [String : Any]{
            if let cities = cityResource["Cities"]  as? [String : Any]{
                if let city = cities["City"] as? [[String : Any]] {
                    return city
                }
            }
        }
        return nil
    }
    
}
