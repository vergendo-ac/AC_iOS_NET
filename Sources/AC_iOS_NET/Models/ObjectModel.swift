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
            self.filename = "iosImage1.jpg"
        }

    }
    
    public struct Placeholder: Codable {
        public var projections: [Projection]
        
        public init(points: [CGPoint], offset: CGPoint = .zero, scale: CGFloat = 1.0) {
            self.projections = [Projection(points: points, offset: offset, scale: scale)]
        }
    }

    public struct ObjectModel: Codable {
        public let sticker: CommonModel.Sticker
        public var placeholder: Placeholder
        
        public init(stickerFields: [CommonModel.StickerField:String], points: [CGPoint], offset: CGPoint = .zero, scale: CGFloat = 1.0) {
            
            let sticker = stickerFields.reduce(into: CommonModel.Sticker(), { $0.set(for: $1.key, value: $1.value) })
            
            self.sticker = sticker
            self.placeholder = Placeholder(points: points, offset: offset, scale: scale)
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
                    let imageMedia = Media(with: jsnD, fileName: "description.json", forKey: "description", mimeType: .json)
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
    
    public enum DeleteObject {
        public struct Request: Encodable {
            public let stickerID: String
            
            public init(stickerID: String) {
                self.stickerID = stickerID
            }
            
        }
        
        public struct Response: Decodable {
            public let status: CommonModel.ServerStatusResponse
        }
    }

    
}
