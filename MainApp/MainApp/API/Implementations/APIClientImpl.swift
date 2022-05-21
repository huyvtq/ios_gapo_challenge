//
//  APIClientImpl.swift
//  MainApp
//
//  Created by HuyQuoc on 03/05/2022.
//

import Alamofire
//MARK: - APIClientImpl
class APIClientImpl: APIClient {
    private let codableParser: CodableParseHelper = CodableParseHelper()
    private let baseURL: String
    
    //MARK: -
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func get<T, Parameters>(endPoint: String, parameters: Parameters?, parse: T.Type, complete: ((T) -> ())?, failure: ((Error) -> ())?) where T : Decodable, T : Encodable, Parameters : Encodable {
        request(endPoint: endPoint, method: HTTPMethod.get, parameters: parameters, headers: nil, encoder: URLEncodedFormParameterEncoder.default, parse: T.self, complete: complete, failure: failure)
    }
    
    private func request<T: Codable, Parameters: Encodable>(endPoint : String,
                                                            method: Alamofire.HTTPMethod,
                                                            parameters:Parameters?,
                                                            headers: HTTPHeaders? = nil,
                                                            encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                                                            parse: T.Type,
                                                            complete:((T) -> ())?,
                                                            failure:((Error) -> ())?) {
        
        let urlRequestString: String = baseURL + endPoint
        let requestHeaders: HTTPHeaders = getHeaders()
        log.debug(requestHeaders)
        AF.request(urlRequestString, method: method, parameters: parameters, encoder: encoder, headers: requestHeaders)
            .validate(contentType: ["application/json"])
            .response { response in
                log.debug(response.debugDescription)
                switch response.result {
                case let .success(data):
                    guard let data = data else {
                        failure?(APIError.default)
                        return
                    }
                    do {
                        let result: T = try self.codableParser.parse(data: data)
                        complete?(result)
                    } catch let error {
                        failure?(error)
                    }
                case let .failure(error):
                    guard let statusCode = response.response?.statusCode else {
                        failure?(error)
                        return
                    }
                    failure?(APIError.error(for: statusCode))
                }
            }.cURLDescription { curl in
                log.debug(curl)
            }
    }
}

extension APIClientImpl {
    fileprivate func getHeaders() -> HTTPHeaders {
        //        [
        //            "accept": "*/*",
        //            "device_version": config.deviceOSVersion,
        //            "app_version": "\(config.appVersion)",
        //            "device_type": config.deviceType,
        //            "accesskey": sessionRepository.accessKey ?? "",
        //            "token": sessionRepository.token ?? "",
        //            "lang": sessionRepository.languageCode,
        //            "device_id": sessionRepository.deviceId ?? ""
        //        ]
        return HTTPHeaders.default
    }
}
