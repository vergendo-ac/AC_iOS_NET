//
//  File.swift
//  
//
//  Created by Mac on 27.07.2020.
//

import Foundation
import CoreGraphics

public enum ObjectModel {

    public struct Sticker: Codable {
        let path: String?
        let sticker_text: String?
        let sticker_type: String?
        let created_by: String?
        let creation_date: String?
        let sticker_subtype: String?
        let description: String?
        
        public init(path: String? = nil,
                    sticker_text: String? = nil,
                    sticker_type: String? = nil,
                    created_by: String? = nil,
                    creation_date: String? = nil,
                    sticker_subtype: String? = nil,
                    description: String? = nil) {
            self.path = path
            self.sticker_text = sticker_text
            self.sticker_type = sticker_type
            self.created_by = created_by
            self.creation_date = creation_date
            self.sticker_subtype = sticker_subtype
            self.description = description
        }
    }

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
        var projections: [Projection]
    }

    public struct StickerModel {
        let stickerFrame: Dictionary<String, CGPoint>?
        let stickerOffset: CGPoint?
        let scaleCoeff: CGFloat?
        let sticker: Sticker
    }

    public struct ObjectModel: Codable {
        let sticker: Sticker
        var placeholder: Placeholder
        
        public mutating func add(filename: String, index: Int = 0) -> ObjectModel {
            self.placeholder.projections[index].filename = filename
            return self
        }
    }

}
