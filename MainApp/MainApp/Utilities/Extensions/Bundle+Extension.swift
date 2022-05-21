//
//  Bundle+Ext.swift
//  MainApp
//
//  Created by HuyQuoc on 11/05/2022.
//

import Foundation
extension Bundle{
    func string(forInfoDictionaryKey key: String) -> String {
        return self.object(forInfoDictionaryKey: key) as! String
    }
}
