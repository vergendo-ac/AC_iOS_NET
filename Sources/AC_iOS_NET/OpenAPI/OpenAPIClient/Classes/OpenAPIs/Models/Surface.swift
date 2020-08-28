//
// Surface.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct Surface: Codable { 


    public var pose: Pose
    public var frame: [Vector2d]

    public init(pose: Pose, frame: [Vector2d]) {
        self.pose = pose
        self.frame = frame
    }

}