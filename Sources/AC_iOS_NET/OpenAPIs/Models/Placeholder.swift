//
// Placeholder.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct Placeholder: Codable { 


    public var placeholderId: String

    public init(placeholderId: String) {
        self.placeholderId = placeholderId
    }

    public enum CodingKeys: String, CodingKey, CaseIterable { 
        case placeholderId = "placeholder_id"
    }

}
