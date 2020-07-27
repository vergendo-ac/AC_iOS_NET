//
//  File.swift
//  
//
//  Created by Mac on 27.07.2020.
//

import Foundation

struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String

    init?(with data: Data, name: String, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(name).jpeg"
        self.data = data
    }
}
