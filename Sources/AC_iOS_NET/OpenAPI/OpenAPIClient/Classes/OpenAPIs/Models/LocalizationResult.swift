//
// LocalizationResult.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct LocalizationResult: Codable { 


    public var camera: Camera?
    public var reconstructionId: String?
    public var placeholders: [PlaceholderNode3d]?
    public var surfaces: [Surface]?
    public var objects: [ARObject]?
    public var status: LocalizationStatus

    public init(camera: Camera? = nil, reconstructionId: String? = nil, placeholders: [PlaceholderNode3d]? = nil, surfaces: [Surface]? = nil, objects: [ARObject]? = nil, status: LocalizationStatus) {
        self.camera = camera
        self.reconstructionId = reconstructionId
        self.placeholders = placeholders
        self.surfaces = surfaces
        self.objects = objects
        self.status = status
    }

    public enum CodingKeys: String, CodingKey, CaseIterable { 
        case camera
        case reconstructionId = "reconstruction_id"
        case placeholders
        case surfaces
        case objects
        case status
    }

}
