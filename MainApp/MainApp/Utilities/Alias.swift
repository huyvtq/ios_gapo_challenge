//
//  Alias.swift
//  MainApp
//
//  Created by HuyQuoc on 07/05/2022.
//

import Foundation
enum Environment: String {
    case debug = "debug"
    case staging = "staging"
    case production = "production"
    
    static let current: Environment = Environment(rawValue: Bundle.main.string(forInfoDictionaryKey: "ENVIRONMENT"))!
}
