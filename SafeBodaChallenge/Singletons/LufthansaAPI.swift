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
    
    var defaultHeaders = ["Authorization" : "",
                          "Accept" : "application/json",
                          "Content-Type" : "application/json"]
    
    private let numberOfResults = 40
    
    private let baseUrlStr = "https://api.lufthansa.com/v1/"
    
    private override init() { }
    
    func fetchToken(){
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
                    self.defaultHeaders["Authorization"] = "Bearer " + token
                    let unixTimestamp:TimeInterval = dict["expires_in"] as! TimeInterval
                    let date = Date(timeIntervalSince1970: unixTimestamp)
                    print(date)
                }
        }
    }
    
    func fetchAirports(index:Int? = 0 ,
                       completion: @escaping (_ error:String?, _ data:[String : Any]?) -> ()){
        
        let urlString = baseUrlStr + "mds-references/airports"
        
        let parameters = ["recordLimit" : numberOfResults, "recordOffset" : index ]
        
        Alamofire.request(urlString, method: .get, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: defaultHeaders)
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
                    completion(nil,dict)
                    
                }
        }

        }


}
