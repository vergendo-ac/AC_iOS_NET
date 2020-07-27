//
//  File.swift
//  
//
//  Created by Mac on 24.07.2020.
//

import Foundation

enum REST {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    enum API {

        //http://developer.vergendo.com:5000/api/localizer/prepare?lat=9.23123123&lon=8.123123
        enum Localization: String {
            case prepare //http://developer.vergendo.com:5000/api/localizer/prepare
            case localize //http://developer.vergendo.com:5000/api/localizer/localize
            
            var path: String {
                "/localizer/\(self.rawValue)"
            }
            
            var additionalHeaders: [String:String] {
                var headers: [String:String] = ["Accept" : "application/vnd.myplace.v2+json"]
                switch self {
                case .prepare:
                    headers["Content-Type"] = "application/x-www-form-urlencoded"
                case .localize:
                    headers["Content-Type"] = "image/jpeg"
                }
                return headers
            }
            
            func getUrl(for serverAddress: String, additionalUrlPart: String = "") -> URL? {
                var urlString: String = serverAddress + "/api" + self.path

                urlString += additionalUrlPart

                print(urlString)
                return URL(string: urlString)
            }
        }
        
    }
    
}
