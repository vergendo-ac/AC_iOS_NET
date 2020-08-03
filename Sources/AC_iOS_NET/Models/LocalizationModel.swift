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
    
    public struct Status: Decodable {
        public let code: Int
        public let message: String
    }
    
    public struct Camera: Decodable {
        public let position: [Double]
        public let orientation: [Double]
    }
    
    public struct Sticker: Decodable {
        public let sticker_id: String
        public let path: String
        public let sticker_text: String
        public let sticker_type: String
        public let sticker_detailed_type: String?
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
        public let points: [[Double]]
    }
    
    public struct Node: Decodable {
        public let node: NodeInfo
    }
    
    public struct Pose: Decodable {
        public let position: [Double]
        public let orientation: [Double]
    }
    
    public struct Surface: Decodable {
        public let frame: [[Double]]
        public let pose: Pose
    }
    
    public struct GPS: Codable {
        public let latitude: Double
        public let longitude: Double
        public let altitude: Double
        public let hdop: Double
        
        public init(from location: CLLocation) {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            self.altitude = location.altitude
            self.hdop = location.horizontalAccuracy
        }
    }

    public struct LocalizeJSONSettings: Codable {
        public let gps: GPS
        public let focalLength: Int
        public let mirrored: Bool //def false
        public let rotation: Int //CW: 0, 90, 180, 270 / def 0
        
        public init(location: CLLocation, focalLength: Int = 0, mirrored: Bool = false, rotation: Int = 0) {
            self.gps = GPS(from: location)
            self.focalLength = focalLength
            self.mirrored = mirrored //def false
            self.rotation = rotation //CW: 0, 90, 180, 270 / def 0
        }

        enum CodingKeys: String, CodingKey {
            case gps = "gps"
            case focalLength = "focal_length_in_35mm_film"
            case mirrored = "mirrored"
            case rotation = "rotation"
        }
    }
    
//____________________________API-STRUCTS_______________________________


    public enum Prepare {
        
        public struct Request: Encodable {
            let lat: Double
            let lon: Double
            let alt: Double
            let dop: Double
            
            public init(location: CLLocation) {
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
            let imageData: [Data]
            let jsonData: Data?
            
            public init(imageData: [Data], jsonData: Data? = nil) {
                self.imageData = imageData
                self.jsonData = jsonData
            }
            
            func getMedia() -> [Media] {
                var localMedia: [Media] = []
                self.imageData.enumerated().forEach { n, d in
                    let imageMedia = Media(with: d, fileName: "iosImage\(n).jpg", forKey: "image", mimeType: .jpg)
                    localMedia.append(imageMedia)
                }
                
                if let jsnD = self.jsonData {
                    let imageMedia = Media(with: jsnD, fileName: "sticker.json", forKey: "description", mimeType: .json)
                    localMedia.append(imageMedia)
                }
                return localMedia
            }
        }
        
        public struct Response: Decodable {
            public let camera: Camera?
            public let objects_info: [ObjectInfo]?
            public let scene_id: String?
            public let scene: [Node]?
            public let surfaces: [Surface]?
            public let status: Status
        }
    }
    
}
