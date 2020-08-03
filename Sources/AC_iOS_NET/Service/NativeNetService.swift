//
//  File.swift
//  
//
//  Created by Mac on 24.07.2020.
//

import Foundation

class NativeNetService {
    
    static let sharedInstance = NativeNetService()
    
    let session = URLSession(configuration: .default)
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var tasks = [URLRequest: [completionHandler]]()
    
    func dataTask(for data: Data? = nil, with additionalHeaders: [String:String]? = nil, with url: URL, restMethod: REST.Method, completion: @escaping completionHandler) {
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = restMethod.rawValue
        
        if let headers = request.allHTTPHeaderFields, headers.count > 0, let adHeaders = additionalHeaders {
            
            for (key, value) in adHeaders {
                request.allHTTPHeaderFields?[key] = value
            }
            
        } else {
            request.allHTTPHeaderFields = additionalHeaders
        }
        
        
        // insert data to the request
        if let data = data {
            request.httpBody = data
        }
        
        //session.configuration.httpAdditionalHeaders = additionalHeaders
        
        
        if tasks.keys.contains(request) {
            tasks[request]?.append(completion)
        } else {
            tasks[request] = [completion]
            
            let _ = self.session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    
                    print("Finished network task")
                    if let d = data {
                        print(String(data: d, encoding: .utf8)!)
                    }
                    
                    if let e = error {
                        print(e)
                        print(e.localizedDescription)
                    }
                    
                    if let r = response {
                        print(r)
                        print(r.url)
                        print(r.debugDescription)
                        print(r.description)
                    }
                    

                    guard let completionHandlers = self?.tasks[request] else { return }
                    for handler in completionHandlers {
                        
                        print("Executing completion block")
                        
                        handler(data, response, error)
                    }
                    self?.tasks.removeValue(forKey: request)
                }
            }).resume()

        }
        
    }
    
    func dataTaskMultiPart(for media: [Media], with additionalHeaders: [String:String]? = nil, with url: URL, restMethod: REST.Method, completion: @escaping completionHandler) {
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = restMethod.rawValue
        
        if let headers = request.allHTTPHeaderFields, headers.count > 0, let adHeaders = additionalHeaders {
            
            for (key, value) in adHeaders {
                request.allHTTPHeaderFields?[key] = value
            }
            
        } else {
            request.allHTTPHeaderFields = additionalHeaders
        }
        
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        // insert data to the request
        request.httpBody = createMultipartDataBody(media: media, boundary: boundary)
        
        //session.configuration.httpAdditionalHeaders = additionalHeaders
        
        
        if tasks.keys.contains(request) {
            tasks[request]?.append(completion)
        } else {
            tasks[request] = [completion]
            
            let _ = self.session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    
                    print("Finished network task")
                    if let d = data {
                        print(String(data: d, encoding: .utf8)!)
                    }
                    
                    if let e = error {
                        print(e)
                        print(e.localizedDescription)
                    }
                    
                    if let r = response {
                        print(r)
                        print(r.url)
                        print(r.debugDescription)
                        print(r.description)
                    }
                    

                    guard let completionHandlers = self?.tasks[request] else { return }
                    for handler in completionHandlers {
                        
                        print("Executing completion block")
                        
                        handler(data, response, error)
                    }
                    self?.tasks.removeValue(forKey: request)
                }
            }).resume()

        }
        
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createMultipartDataBody(media: [Media], boundary: String) -> Data {

        let lineBreak = "\r\n"
        var body = Data()
       
        for photo in media {
            body.append(self.convertFileData(media: photo, using: boundary))
        }

        body.append("--\(boundary)--")

        return body
    }
    
    func convertFormField(named name: String, value: String, using boundary: String) -> String {
      var fieldString = "--\(boundary)\r\n"
      fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
      fieldString += "\r\n"
      fieldString += "\(value)\r\n"

      return fieldString
    }
    
    func convertFileData(media: Media, using boundary: String) -> Data {
      let data = NSMutableData()

      data.append("--\(boundary)\r\n")
        data.append("Content-Disposition: form-data; name=\"\(media.key)\"; filename=\"\(media.fileName)\"\r\n")
        data.append("Content-Type: \(media.mimeType.rawValue)\r\n\r\n")
        data.append(media.data)
      data.append("\r\n")

      return data as Data
    }
    
}
