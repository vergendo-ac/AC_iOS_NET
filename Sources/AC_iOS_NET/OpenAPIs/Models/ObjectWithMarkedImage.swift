//
// ObjectWithMarkedImage.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ObjectWithMarkedImage: Codable {

    public var placeholder: PlaceholderImage
    public var sticker: StickerData

    public init(placeholder: PlaceholderImage, sticker: StickerData) {
        self.placeholder = placeholder
        self.sticker = sticker
    }

}

