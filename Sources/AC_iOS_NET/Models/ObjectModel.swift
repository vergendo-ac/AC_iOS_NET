//
//  File.swift
//  
//
//  Created by Mac on 05.08.2020.
//

import Foundation
import CoreGraphics

public enum ObjectModel {
        
    public struct Projection: Codable {
        var points: [[Int]]
        var filename: String
        
        public init(points: [CGPoint], offset: CGPoint = .zero, scale: CGFloat = 1.0) {
            self.points = points.map {
                [Int(($0.x - offset.x) / scale), Int(($0.y - offset.y) / scale)]
            }
            self.filename = ""
        }

    }
    
    public struct Placeholder: Codable {
        public var projections: [Projection]
        
        public init(points: [CGPoint]) {
            self.projections = [Projection(points: points)]
        }
    }

    public struct ObjectModel: Codable {
        public let sticker: CommonModel.Sticker
        public var placeholder: Placeholder
        
        public init(text: String, points: [CGPoint]) {
            self.sticker = CommonModel.Sticker()
            self.placeholder = Placeholder(points: points)
        }
        
        public mutating func add(filename: String, index: Int = 0) -> ObjectModel {
            self.placeholder.projections[index].filename = filename
            return self
        }
    }
    
    public struct StickerPlaceholderResponse: Decodable {
        public let sticker: CommonModel.Sticker
        public let placeholder: CommonModel.PlaceholderResponse
    }
    
    //____________________________API-STRUCTS_______________________________

    public enum AddObject {
        public struct Request: Encodable {
            let imageData: Data
            let jsonData: Data?
            
            public init(imageData: Data, jsonData: Data?) {
                self.imageData = imageData
                self.jsonData = jsonData
            }
            
            func getMedia() -> [Media] {
                var localMedia: [Media] = []

                if let jsnD = self.jsonData {
                    let imageMedia = Media(with: jsnD, fileName: "description", forKey: "description", mimeType: .json)
                    localMedia.append(imageMedia)
                }

                let imageMedia = Media(with: imageData, fileName: "iosImage1.jpg", forKey: "image", mimeType: .jpg)
                localMedia.append(imageMedia)
                
                return localMedia
            }
        }
        
        public struct Response: Decodable {
            public let objects_info: [StickerPlaceholderResponse]
            public let status: CommonModel.ServerStatusResponse
        }
    }
    
}
