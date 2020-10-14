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
        
        public typealias deleteObjectResponse = ObjectModel.DeleteObject.Response
        public typealias deleteObjectCompletionHandler = (deleteObjectResponse?, URLResponse?, Error?) -> Void

        public static func deleteObject(from serverAddress: String = Servers.addresses[0], by request: ObjectModel.DeleteObject.Request, completion: @escaping deleteObjectCompletionHandler) {
            guard let url = REST.API.ObjectOperations.delete.getUrl(for: serverAddress, additionalUrlPart: "?id=\(request.stickerID)") else { completion(nil, nil, nil); return }

            nativeNet.dataTask(
            with: REST.API.ObjectOperations.delete.additionalHeaders,
                with: url,
                restMethod: .DELETE)
            { (mData, mResponse, mError) in
                guard mError == nil else { completion(nil, mResponse, mError); return }
                guard let data = mData else { completion(nil, mResponse, nil); return }
                
                do {
                    //print(data)
                    print(String(data: data, encoding: .utf8)!)
                    let deleteResponse = try JSONDecoder().decode(ObjectModel.DeleteObject.Response.self, from: data)
                    completion(deleteResponse, mResponse, nil)
                } catch {
                    print(error.localizedDescription)
                    print(error)
                    print(String(data: data, encoding: .utf8)!)
                    completion(nil, mResponse, error)
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
    
}
