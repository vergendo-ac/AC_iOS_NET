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
   }
    
}
