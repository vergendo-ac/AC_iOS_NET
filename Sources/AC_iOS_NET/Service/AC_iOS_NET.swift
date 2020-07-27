import Foundation
import CoreLocation

struct AC_iOS_NET {
    let text = "Hello, World!"
}

open class NET {
    
    static let nativeNet = NativeNetService.sharedInstance
    
    open class Localizer {
        
        public typealias prepareCompletionHandler = (LocalizationModel.Prepare.Response?, URLResponse?, Error?) -> Void
        public static func prepare(at serverAddress: String = Servers.addresses[2], for request: LocalizationModel.Prepare.Request, completion: @escaping prepareCompletionHandler) {
            guard let url = REST.API.Localization.prepare.getUrl(for: serverAddress, additionalUrlPart: request.urlPart) else { completion(nil, nil, nil); return }
            //guard let data = try? JSONEncoder().encode(LocalizationModel.Prepare.Request(location: location)) else { completion(nil, nil, nil); return }
            
            nativeNet.dataTask(
                with: REST.API.Localization.prepare.additionalHeaders,
                with: url,
                restMethod: REST.Method.GET) { sData, sResponse, sError in
                    guard sError == nil else { completion(nil, nil, sError); return }
                    guard let data = sData else { completion(nil, nil, nil); return }
                    
                    do {
                        //print(data)
                        //print(String(data: data, encoding: .utf8)!)
                        let prepareStatus = try JSONDecoder().decode(LocalizationModel.Prepare.Response.self, from: data)
                        completion(prepareStatus, nil, nil)
                    } catch {
                        //print(error.localizedDescription)
                        //print(error)
                        //print(String(data: data, encoding: .utf8)!)
                        completion(nil, nil, error)
                    }
            }
        }
        
        public typealias localizeCompletionHandler = (LocalizationModel.Localize.Response?, URLResponse?, Error?) -> Void
        public static func localize(at serverAddress: String = Servers.addresses[0], for request: LocalizationModel.Localize.Request, completion: @escaping localizeCompletionHandler) {
            guard let url = REST.API.Localization.localize.getUrl(for: serverAddress) else { completion(nil, nil, nil); return }
            
            nativeNet.dataTask(
                for: request.imageData,
                with: REST.API.Localization.localize.additionalHeaders,
                with: url,
                restMethod: .POST) { sData, sResponse, sError in
                    guard sError == nil else { completion(nil, nil, sError); return }
                    guard let data = sData else { completion(nil, nil, nil); return }
                    
                    do {
                        //print(data)
                        print(String(data: data, encoding: .utf8)!)
                        let localizationResponse = try JSONDecoder().decode(LocalizationModel.Localize.Response.self, from: data)
                        completion(localizationResponse, nil, nil)
                    } catch {
                        print(error.localizedDescription)
                        print(error)
                        print(String(data: data, encoding: .utf8)!)
                        completion(nil, nil, error)
                    }
            }
            
        }
        
    }
    
}
