//
// Pose.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct Pose: Codable { 


    public var position: Vector3d
    public var orientation: Quaternion

    public init(position: Vector3d, orientation: Quaternion) {
        self.position = position
        self.orientation = orientation
    }

}
