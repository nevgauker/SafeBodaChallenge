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
    
    let defaultHeaders = ["Authorization" : "",
                          "Accept" : "application/json",
                          "Content-Type" : "application/json"]
    
    private override init() { }
    
    func fetchToken(){
        let urlString = "https://api.lufthansa.com/v1/oauth/token"
        
        let parameters: Parameters = ["client_id": "zxgk2qyz6dtw8u9dpnd8nx5w",
                                      "client_secret" : "3YB8SHvvCd",
                                      "grant_type" : "client_credentials"]
        
        
        
      
        
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [ "Content-Type" : "pplication/x-www-form-urlencoded" ])
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
        }
        
        
        
    
        

    }


}
