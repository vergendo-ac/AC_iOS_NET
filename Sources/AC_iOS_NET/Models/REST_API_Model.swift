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
        
        enum Localization: String {
            case prepare //http://developer.vergendo.com:5000/api/localizer/prepare
            case localize //http://developer.vergendo.com:5000/api/localizer/localize
            
            var path: String {
                "/localizer/\(self.rawValue)"
            }
            
            var additionalHeaders: [String:String] {
                ["Accept" : "application/vnd.myplace.v2+json"]
            }
            
            func getUrl(for serverAddress: String) -> URL? {
                URL(string: serverAddress + "/api" + self.path)
            }
        }
        
    }
    
}
