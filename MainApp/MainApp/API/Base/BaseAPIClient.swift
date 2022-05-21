//
//  BaseAPIClient.swift
//  MainApp
//
//  Created by HuyQuoc on 03/05/2022.
//

import Foundation
class BaseAPIClient {
    public let client: APIClient
    public let emptyParameters: EmptyParameters?
    
    init(client: APIClient) {
        self.client = client
        self.emptyParameters = nil
    }
    
    struct EmptyParameters: Encodable {
        
    }
}
