//
// PrepareStatus.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct PrepareStatus: Codable {

    public enum Code: Int, Codable, CaseIterable {
        case _0 = 0
        case _1 = 1
    }
    /** | State   | Code   |  Description  |   | -- | -- | -- |   | Success | 0 | Server is loading nearby data |   | Fail | 1 | No nearby reconstructions to localize in |   */
    public var code: Code
    public var message: String

    public init(code: Code, message: String) {
        self.code = code
        self.message = message
    }

}

