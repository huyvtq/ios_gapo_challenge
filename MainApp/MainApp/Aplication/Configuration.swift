//
//  Configuration.swift
//  application
//
//  Created by HuyQuoc on 26/03/2022.
//

import Foundation
internal class Configuration {
    
    let baseApiUrl: String
    
    init(){
        baseApiUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_API_URL") as! String
    }
}
