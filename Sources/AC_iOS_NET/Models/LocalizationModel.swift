//
//  File.swift
//  
//
//  Created by Mac on 24.07.2020.
//

import Foundation
import CoreLocation

public enum LocalizationModel {
    
//-------------API-HELPER-STRUCTS------------------------
    
    struct Status: Decodable {
        let code: Int
        let message: String
    }
    
    struct Camera: Decodable {
        let position: [Int]
        let orientation: [Int]
    }
    
    struct Sticker: Decodable {
        let sticker_id: String
        let path: String
        let sticker_text: String
        let sticker_type: String
        let sticker_detailed_type: String
    }
    
    struct Placeholder: Decodable {
        let placeholder_id: String
    }
    
    struct ObjectInfo: Decodable {
        let sticker: Sticker
        let placeholder: Placeholder
    }
    
    struct NodeInfo: Decodable {
        let id: String
        let points: [[Int]]
    }
    
    struct Node: Decodable {
        let node: NodeInfo
    }
    
    struct Pose: Decodable {
        let position: [Int]
        let orientation: [Int]
    }
    
    struct Surface: Decodable {
        let frame: [[Int]]
        let pose: Pose
    }
    
//____________________________API-STRUCTS_______________________________


    public enum Prepare {
        
        struct Request: Encodable {
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
            
        }
        
        public struct Response: Decodable {
            let status: Status
        }

    }

    enum Localize {
        
        struct Request: Encodable {
            let imageData: Data
        }
        
        struct Response: Decodable {
            let camera: Camera
            let objects_info: [ObjectInfo]
            let scene_id: String
            let scene: [Node]
            let surfaces: [Surface]
            let status: Status
        }
    }
    
}
