//
// ARObject.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct ARObject: Codable { 


    public var placeholder: Placeholder
    public var sticker: [String:String]

    public init(placeholder: Placeholder, sticker: [String:String]) {
        self.placeholder = placeholder
        self.sticker = sticker
    }

}