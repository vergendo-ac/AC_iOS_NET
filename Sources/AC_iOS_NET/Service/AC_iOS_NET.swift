import Foundation
import CoreLocation

struct AC_iOS_NET {
    let text = "Hello, World!"
}

open class NET {
    
    static let naitiveNet = NativeNetService.sharedInstance
    
    open class Localizer {
        
        public typealias prepareCompletionHandler = (LocalizationModel.Prepare.Response?, URLResponse?, Error?) -> Void
        public static func prepare(for location: CLLocation, completion: @escaping prepareCompletionHandler) {
            guard let url = REST.API.Localization.prepare.getUrl(for: Servers.addresses[2], location: LocalizationModel.Prepare.Request(location: location)) else { completion(nil, nil, nil); return }
            //guard let data = try? JSONEncoder().encode(LocalizationModel.Prepare.Request(location: location)) else { completion(nil, nil, nil); return }
            
            naitiveNet.dataTask(
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

        public static func localize() {
            
        }
        
    }
    
}
