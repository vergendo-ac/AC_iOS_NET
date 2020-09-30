//
// LocalizerAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



open class LocalizerAPI {
    /**
     Localize camera
     
     - parameter description: (form)  
     - parameter image: (form) A JPEG-encoded image 
     - parameter hint: (form)  (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func localize(server address: String? = nil, description: ImageDescription, image: URL, hint: LocalizationHint? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: LocalizationResult?,_ error: Error?) -> Void)) {
        localizeWithRequestBuilder(server: address, description: description, image: image, hint: hint).execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Localize camera
     - POST /localizer/localize
     - Localize uploaded image. Return camera pose and optional placeholders scene, surfaces scene and objects content. Camera, placeholders and surfaces coordinates are local coordinates in reconstruction coordinate system identified by reconstruction id.
     - parameter description: (form)  
     - parameter image: (form) A JPEG-encoded image 
     - parameter hint: (form)  (optional)
     - returns: RequestBuilder<LocalizationResult> 
     */
    open class func localizeWithRequestBuilder(server address: String? = nil,description: ImageDescription, image: URL, hint: LocalizationHint? = nil) -> RequestBuilder<LocalizationResult> {
        let path = "/localizer/localize"
        let addressString = address == nil ? OpenAPIClientAPI.basePath : "\(address!)/api/v2"
        let URLString = addressString + path

        
        let formParams: [String:Any?] = [
            "description": description.encodeToJSON(),
            "image": image.encodeToJSON(),
            "hint": hint?.encodeToJSON()
        ]

        let nonNullParameters = APIHelper.rejectNil(formParams)
        let parameters = APIHelper.convertBoolToString(nonNullParameters)
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<LocalizationResult>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Prepare localization session
     
     - parameter lat: (query) GPS latitude 
     - parameter lon: (query) GPS longitude 
     - parameter alt: (query) GPS altitude (optional) (optional)
     - parameter dop: (query) GPS HDOP (optional) (optional)
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func prepare(lat: Double, lon: Double, alt: Double? = nil, dop: Double? = nil, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: PrepareResult?,_ error: Error?) -> Void)) {
        prepareWithRequestBuilder(lat: lat, lon: lon, alt: alt, dop: dop).execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    /**
     Prepare localization session
     - GET /localizer/prepare
     - Prepare for localization for given geolocation. Causes server to load nearby reconstructions for localization. Returns an error when localization in this location is not possible.
     - parameter lat: (query) GPS latitude 
     - parameter lon: (query) GPS longitude 
     - parameter alt: (query) GPS altitude (optional) (optional)
     - parameter dop: (query) GPS HDOP (optional) (optional)
     - returns: RequestBuilder<PrepareResult> 
     */
    open class func prepareWithRequestBuilder(lat: Double, lon: Double, alt: Double? = nil, dop: Double? = nil) -> RequestBuilder<PrepareResult> {
        let path = "/localizer/prepare"
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "lat": lat.encodeToJSON(), 
            "lon": lon.encodeToJSON(), 
            "alt": alt?.encodeToJSON(), 
            "dop": dop?.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<PrepareResult>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
