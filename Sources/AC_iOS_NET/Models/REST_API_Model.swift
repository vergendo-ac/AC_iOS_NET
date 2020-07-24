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
                ["Accept" : "application/vnd.myplace.v2+json"]
            }
            
            func getUrl(for serverAddress: String, location: LocalizationModel.Prepare.Request) -> URL? {
                let urlString = serverAddress + "/api" + self.path + location.urlPart
                print(urlString)
                return URL(string: urlString)
            }
        }
        
    }
    
}
