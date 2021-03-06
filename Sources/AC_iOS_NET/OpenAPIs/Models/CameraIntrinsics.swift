//
// CameraIntrinsics.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

/** Intrinsics are based on physical characteristics of the device camera and a pinhole camera model. */
public struct CameraIntrinsics: Codable {

    /** Focal length */
    public var fx: Float
    /** Focal length */
    public var fy: Float
    /** Principal point */
    public var cx: Float
    /** Principal point */
    public var cy: Float

    public init(fx: Float, fy: Float, cx: Float, cy: Float) {
        self.fx = fx
        self.fy = fy
        self.cx = cx
        self.cy = cy
    }

}

