import Foundation
import CoreLocation

struct AC_iOS_NET {
    let text = "Hello, World!"
    let text2 = "Hello, World2!"
}

open class NET {
    
    static let nativeNet = NativeNetService.sharedInstance
    
    open class Common {
        
        public static func runNetTask(for data: Data? = nil, with additionalHeaders: [String : String]? = nil, with url: URL, restMethod: REST.Method, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
            nativeNet.dataTask(for: data, with: additionalHeaders, with: url, restMethod: restMethod, completion: completion)
        }
        
    }
    
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
        
        public typealias localizeMPDResponse = LocalizationModel.Localize.Response
        public typealias localizeMPDCompletionHandler = (localizeMPDResponse?, URLResponse?, Error?) -> Void
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
        
        public typealias localizationResultSwagger = LocalizationResult
        public typealias imageDescription = ImageDescription
        public static func localizeSwagger(server address: String = Servers.addresses[0], for image: URL, with description: imageDescription, completion: @escaping ((_ data: localizationResultSwagger?,_ error: Error?) -> Void)) {
            LocalizerAPI.localize(server: address, description: description, image: image, apiResponseQueue: .main) { (localizeResult, error) in
                completion(localizeResult, error)
            }
        }

    }
    
    open class ObjectOperator {
        public typealias addObjectModel = ObjectModel.ObjectModel
        public typealias addObjectResponse = ObjectModel.AddObject.Response
        public typealias stickerField = CommonModel.StickerField
        public typealias addObjectMPDCompletionHandler = (addObjectResponse?, URLResponse?, Error?) -> Void
        
        //MARK: Local API
        public static func addObjectMPD(to serverAddress: String = Servers.addresses[0], for request: ObjectModel.AddObject.Request, completion: @escaping addObjectMPDCompletionHandler) {
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
        
        //MARK: Open API
        public typealias addObjectWithPoseCompletionHandler = (AddObjectResult?, Error?) -> Void
        public static func addObjectWithPose(server address: String? = nil, objectWithPose: ObjectWithPose, apiResponseQueue: DispatchQueue, completion: @escaping addObjectWithPoseCompletionHandler) {
            ObjectsAPI.addObjectByPose(server: address, objectWithPose: objectWithPose, apiResponseQueue: apiResponseQueue, completion: completion)
        }
        
        public typealias addObjectByImageCompletionHandler = (AddObjectResult?, Error?) -> Void
        public typealias objectWithMarkedImage = ObjectWithMarkedImage
        public static func addObjectByImage(server address: String? = nil, description: objectWithMarkedImage, image: URL, apiResponseQueue: DispatchQueue, completion: @escaping addObjectByImageCompletionHandler) {
            ObjectsAPI.addObjectByImage(server: address, description: description, image: image, apiResponseQueue: apiResponseQueue, completion: completion)
        }

    }
    
    open class ReconstructionOperator {
        
        public static func getAllCities(apiResponseQueue: DispatchQueue = .main, completion: @escaping (_ data: [AugmentedCity]?,_ error: Error?) -> Void) {
            ReconstructionAPI.getAllCities(apiResponseQueue: apiResponseQueue, completion: completion)
        }
        
        public static func getCityByGps(location: CLLocation, apiResponseQueue: DispatchQueue = .main, completion: @escaping (_ data: AugmentedCity?,_ error: Error?) -> Void) {
            ReconstructionAPI.getCityByGps(pLatitude: location.coordinate.latitude, pLongitude: location.coordinate.longitude, apiResponseQueue: apiResponseQueue, completion: completion)
        }

    }
    
}
