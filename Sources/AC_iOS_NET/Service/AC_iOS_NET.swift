import Foundation
import CoreLocation

struct AC_iOS_NET {
    let text = "Hello, World!"
}

open class NET {
    
    static let nativeNet = NativeNetService.sharedInstance
    
    open class Localizer {
        
        public typealias prepareCompletionHandler = (LocalizationModel.Prepare.Response?, URLResponse?, Error?) -> Void
        public static func prepare(at serverAddress: String = Servers.addresses[0], for request: LocalizationModel.Prepare.Request, completion: @escaping prepareCompletionHandler) {
            guard let url = REST.API.Localization.prepare.getUrl(for: serverAddress, additionalUrlPart: request.urlPart) else { completion(nil, nil, nil); return }
            //guard let data = try? JSONEncoder().encode(LocalizationModel.Prepare.Request(location: location)) else { completion(nil, nil, nil); return }
            
            nativeNet.dataTask(
                with: REST.API.Localization.prepare.additionalHeaders,
                with: url,
                restMethod: .GET) { sData, sResponse, sError in
                    
                    guard sError == nil else { completion(nil, sResponse, sError); return }
                    guard let data = sData else { completion(nil, sResponse, nil); return }
                    
                    do {
                        //print(data)
                        //print(String(data: data, encoding: .utf8)!)
                        let prepareStatus = try JSONDecoder().decode(LocalizationModel.Prepare.Response.self, from: data)
                        completion(prepareStatus, sResponse, nil)
                    } catch {
                        //print(error.localizedDescription)
                        //print(error)
                        //print(String(data: data, encoding: .utf8)!)
                        completion(nil, sResponse, error)
                    }
            }
        }
        
        public typealias localizeCompletionHandler = (LocalizationModel.Localize.Response?, URLResponse?, Error?) -> Void
        public static func localize(at serverAddress: String = Servers.addresses[0], for request: LocalizationModel.Localize.Request, completion: @escaping localizeCompletionHandler) {
            guard let url = REST.API.Localization.localize.getUrl(for: serverAddress) else { completion(nil, nil, nil); return }
            
            nativeNet.dataTask(
                for: request.imageData[0],
                with: REST.API.Localization.localize.additionalHeaders,
                with: url,
                restMethod: .POST) { sData, sResponse, sError in
                    guard sError == nil else { completion(nil, sResponse, sError); return }
                    guard let data = sData else { completion(nil, sResponse, nil); return }
                    
                    do {
                        //print(data)
                        print(String(data: data, encoding: .utf8)!)
                        let localizationResponse = try JSONDecoder().decode(LocalizationModel.Localize.Response.self, from: data)
                        completion(localizationResponse, sResponse, nil)
                    } catch {
                        print(error.localizedDescription)
                        print(error)
                        print(String(data: data, encoding: .utf8)!)
                        completion(nil, sResponse, error)
                    }
            }
            
        }
        
        public typealias localizeMPDCompletionHandler = (LocalizationModel.Localize.Response?, URLResponse?, Error?) -> Void
        public static func localizeMPD(at serverAddress: String = Servers.addresses[0], for request: LocalizationModel.Localize.Request, completion: @escaping localizeMPDCompletionHandler) {
            guard let url = REST.API.Localization.localize.getUrl(for: serverAddress) else { completion(nil, nil, nil); return }
            
            nativeNet.dataTaskMultiPart(
                for: request.getMedia(),
                with: REST.API.Localization.localize.additionalHeaders,
                with: url,
                restMethod: .POST
            ) { sData, sResponse, sError in
                guard sError == nil else { completion(nil, sResponse, sError); return }
                guard let data = sData else { completion(nil, sResponse, nil); return }
                
                do {
                    //print(data)
                    print(String(data: data, encoding: .utf8)!)
                    let localizationResponse = try JSONDecoder().decode(LocalizationModel.Localize.Response.self, from: data)
                    completion(localizationResponse, sResponse, nil)
                } catch {
                    print(error.localizedDescription)
                    print(error)
                    print(String(data: data, encoding: .utf8)!)
                    completion(nil, sResponse, error)
                }
            }
            
        }
        
    }
    
    open class ObjectOperator {
        public typealias addObjectMPDCompletionHandler = (ObjectModel.AddObject.Response?, URLResponse?, Error?) -> Void
        public typealias addObjectModel = ObjectModel.ObjectModel

        public static func addObjectMPD(at serverAddress: String = Servers.addresses[0], for request: ObjectModel.AddObject.Request, completion: @escaping addObjectMPDCompletionHandler) {
            guard let url = REST.API.ObjectOperations.object.getUrl(for: serverAddress) else { completion(nil, nil, nil); return }
            
            nativeNet.dataTaskMultiPart(
                for: request.getMedia(),
                with: REST.API.ObjectOperations.object.additionalHeaders,
                with: url,
                restMethod: .POST
            ) { sData, sResponse, sError in
                guard sError == nil else { completion(nil, sResponse, sError); return }
                guard let data = sData else { completion(nil, sResponse, nil); return }
                
                do {
                    //print(data)
                    print(String(data: data, encoding: .utf8)!)
                    let localizationResponse = try JSONDecoder().decode(ObjectModel.AddObject.Response.self, from: data)
                    completion(localizationResponse, sResponse, nil)
                } catch {
                    print(error.localizedDescription)
                    print(error)
                    print(String(data: data, encoding: .utf8)!)
                    completion(nil, sResponse, error)
                }
            }
            
        }
    }
    
}
