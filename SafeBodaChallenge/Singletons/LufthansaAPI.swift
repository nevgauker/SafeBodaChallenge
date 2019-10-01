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
                    let token:String =  dict["access_token"] as! String
                    _ = Utils.saveToken(token: token)
                    self.defaultHeaders["Authorization"] = "Bearer " + token
                    let secs:Int = dict["expires_in"] as! Int
                    
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .second, value:secs , to: Date())
                    
                    let defaults = UserDefaults.standard
                    
                    defaults.set(date, forKey: "expired")
                    defaults.synchronize()
                    
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
    func fetchCountries(completion: @escaping (_ error:String?, _ countries : [Country]?) -> ()){
        
        let urlString = baseUrlStr + "mds-references/countries"
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: defaultHeaders)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                if let dict = response.result.value as? Dictionary<String,AnyObject>{
                    if let countriesData = self.handleCountryRespose(dict: dict) {
                        var arr:[Country] = [Country]()
                        for countryData in countriesData {
                            let country:Country = Country(data: countryData)
                            arr.append(country)
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
                       completion: @escaping (_ error:String?,_ airports:[Airport]?) -> ()){
        
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
                        var arr:[Airport] = [Airport]()
                        for airportData in airportsData {
                            let airport:Airport = Airport(data: airportData)
                            arr.append(airport)
                        }
                        completion(nil,arr)
                }else {
                    completion(response.error?.localizedDescription,nil)
                }
        }
        }
    }
    
    
    func fetchSchedules(origin:String,destination:String,fromdate:String,
                       completion: @escaping (_ error:String?,_ schedules:[Schedule]?) -> ()){
        
        let urlString = baseUrlStr + "operations/schedules/" + origin + "/" + destination + "/" + fromdate
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: defaultHeaders)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                if let dict = response.result.value as? Dictionary<String,AnyObject>{
                    
                    if let scedualsData = self.handleScedualstRespose(dict: dict) {
                        var sceduals:[Schedule] = [Schedule]()
                        for scedualData in scedualsData {
                            let scedual:Schedule = Schedule(data: scedualData)
                            sceduals.append(scedual)
                        }
                        completion(nil,sceduals)
                    }else {
                        if dict["ProcessingErrors"] != nil {
                            completion("ProcessingErrors",nil)
                        }
                        completion(response.error?.localizedDescription,nil)
                    }
                }else {
                    completion(response.error?.localizedDescription,nil)
                }
                completion(nil,nil)
        }
    }
    
    
    
    
    
    
    
    private func handleAirportRespose(dict:[String : Any])->[[String : Any]]?{
            if let airportResource = dict["AirportResource"]  as? [String : Any]{
                if let airports = airportResource["Airports"]  as? [String : Any]{
                    if let airport = airports["Airport"] as? [[String : Any]] {
                        return airport
                    }else if let airport = airports["Airport"] as? [String : Any] {
                        var arr:[[String : Any]] = [[String : Any]]()
                        arr.append(airport)
                        return arr
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
                }else if let city = cities["City"] as? [String : Any] {
                    var arr:[[String : Any]] = [[String : Any]]()
                    arr.append(city)
                    return arr
                }
            }
        }
        return nil
    }
    
    private func handleCountryRespose(dict:[String : Any])->[[String : Any]]?{
        if let cityResource = dict["CountryResource"]  as? [String : Any]{
            if let countries = cityResource["Countries"]  as? [String : Any]{
                if let country = countries["Country"] as? [[String : Any]] {
                    return country
                }else if let country = countries["Country"] as? [String : Any] {
                    var arr:[[String : Any]] = [[String : Any]]()
                    arr.append(country)
                    return arr
                }
            }
        }
        return nil
    }

    
    private func handleScedualstRespose(dict:[String : Any])->[[String : Any]]?{
        if let scheduleResource = dict["ScheduleResource"]  as? [String : Any]{
            if let schedules = scheduleResource["Schedule"] as? [[ String  : Any]] {
                    return schedules
            } else if let schedule  =  scheduleResource["Schedule"] as? [String : Any]{
                var sceduals : [[String : Any]] =  [[String : Any]]()
                sceduals.append(schedule)
                return sceduals
            }
        }
        return nil
    }
    
}
