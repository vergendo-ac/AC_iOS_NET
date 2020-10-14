//
// AddObjectStatus.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct AddObjectStatus: Codable {

    public enum Code: Int, Codable, CaseIterable {
        case _0 = 0
        case _1 = 1
    }
    /** | State   | Code   |  Description  |   | -- | -- | -- |   | Success | 0 | Object is added |   | Fail | 1 | Failed to add object |   */
    public var code: Code
    public var message: String

    public init(code: Code, message: String) {
        self.code = code
        self.message = message
    }

}
