//
//  File.swift
//  
//
//  Created by Mac on 07.08.2020.
//

import Foundation

public enum CommonModel {

    public enum ServerStatusCode: Int, Decodable {
      case UnknownCode = -1
      case Successful = 0
      case Failed = 1
      case ServerError = 2
      
      public var title: String {
          switch self {
          case .UnknownCode: return "Unknown code"
          case .Successful: return "Success"
          case .Failed: return "Failed"
          case .ServerError: return "Server error"
          }
      }
      
      public var message: String {
          switch self {
          case .UnknownCode: return "Unknown code"
          case .Successful: return "Operation completed successfully"
          case .Failed: return "Operation failed, message field contains a description"
          case .ServerError: return "Some internal server error occurred"
          }
      }

        public var value: Int {
          return self.rawValue
      }
      
    }

    public struct ServerStatusResponse: Decodable {
      public let code: ServerStatusCode?
      public let message: String?
      
      public lazy var title: String = {
          switch code {
          case .some(let status):
              return status.title
          case .none:
              return "No server status code"
          }
      }()
    }
    
    public struct PlaceholderResponse: Codable {
        public let placeholder_id: String?
    }
    
    public struct Sticker: Codable {
        public let sticker_id: String?
        public let path: String?
        public let sticker_text: String?
        public let sticker_type: String?
        public let sticker_detailed_type: String?
        public let created_by: String?
        public let creation_date: String?
        public let sticker_subtype: String?
        public let description: String?

        init(
            sticker_id: String? = nil,
            path: String? = nil,
            sticker_text: String? = nil,
            sticker_type: String? = nil,
            sticker_detailed_type: String? = nil,
            created_by: String? = nil,
            creation_date: String? = nil,
            sticker_subtype: String? = nil,
            description: String? = nil
        ) {
            self.sticker_id = sticker_id
            self.path = path
            self.sticker_text = sticker_text
            self.sticker_type = sticker_type
            self.sticker_detailed_type = sticker_detailed_type
            self.created_by = created_by
            self.creation_date = creation_date
            self.sticker_subtype = sticker_subtype
            self.description = description
        }
    }
    
}
