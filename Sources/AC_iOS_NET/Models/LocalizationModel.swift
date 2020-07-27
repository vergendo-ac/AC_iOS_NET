//
//  File.swift
//  
//
//  Created by Mac on 24.07.2020.
//

import Foundation
import CoreLocation

open enum LocalizationModel {
    
//-------------API-HELPER-STRUCTS------------------------
    
    public struct Status: Decodable {
        public let code: Int
        public let message: String
    }
    
    public struct Camera: Decodable {
        public let position: [Int]
        public let orientation: [Int]
    }
    
    public struct Sticker: Decodable {
        public let sticker_id: String
        public let path: String
        public let sticker_text: String
        public let sticker_type: String
        public let sticker_detailed_type: String
    }
    
    public struct Placeholder: Decodable {
        public let placeholder_id: String
    }
    
    public struct ObjectInfo: Decodable {
        public let sticker: Sticker
        public let placeholder: Placeholder
    }
    
    public struct NodeInfo: Decodable {
        public let id: String
        public let points: [[Int]]
    }
    
    public struct Node: Decodable {
        public let node: NodeInfo
    }
    
    public struct Pose: Decodable {
        public let position: [Int]
        public let orientation: [Int]
    }
    
    public struct Surface: Decodable {
        public let frame: [[Int]]
        public let pose: Pose
    }
    
//____________________________API-STRUCTS_______________________________


    public enum Prepare {
        
        public struct Request: Encodable {
            let lat: Double
            let lon: Double
            let alt: Double
            let dop: Double
            
            init(location: CLLocation) {
                self.lat = location.coordinate.latitude
                self.lon = location.coordinate.longitude
                self.alt = location.altitude
                self.dop = location.horizontalAccuracy
            }
            
            var urlPart: String {
                "?lat=\(self.lat)&lon=\(self.lon)&alt=\(self.alt)&dop=\(self.dop)"
            }
            
        }
        
        public struct Response: Decodable {
            public let status: Status
        }

    }

    public enum Localize {
        
        public struct Request: Encodable {
            public let imageData: Data
        }
        
        public struct Response: Decodable {
            public let camera: Camera
            public let objects_info: [ObjectInfo]
            public let scene_id: String
            public let scene: [Node]
            public let surfaces: [Surface]
            public let status: Status
        }
    }
    
}
