//
//  File.swift
//  
//
//  Created by Mac on 27.07.2020.
//

import Foundation

public enum MimeType: String {
    case jpg = "image/jpg"
    case json = "application/json"
}

public struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: MimeType

    public init(with data: Data, fileName: String, forKey key: String, mimeType: MimeType) {
        self.key = key
        self.mimeType = mimeType
        self.fileName = fileName
        self.data = data
    }
}
