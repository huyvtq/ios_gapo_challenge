//
//  APIResponse.swift
//  MainApp
//
//  Created by HuyQuoc on 01/05/2022.
//

import Foundation
struct Response<T: Codable> : Codable{
    let message: String?
    let code: Int?
    public let data: T?
}

struct NotificationResponse: Codable {
    let data: [Notification]
}
