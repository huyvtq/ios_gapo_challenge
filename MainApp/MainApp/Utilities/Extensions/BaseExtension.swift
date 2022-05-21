//
//  BaseExtension.swift
//  MainApp
//
//  Created by HuyQuoc on 21/05/2022.
//

import Foundation
import UIKit
extension Date{
    func toNotificationFormat() -> String {
        return toStringDate(withFormat: "dd/MM/yyyy, hh:mm")
    }
    
    public func toStringDate(withFormat stringFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = stringFormat
        
        return formatter.string(from: self)
    }
}


extension String{
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func removeDistrict() -> String {
        return self.folding(options: String.CompareOptions.diacriticInsensitive, locale: Locale.current)
            .replacingOccurrences(of: "đ", with: "d")
            .replacingOccurrences(of: "Đ", with: "D")
    }
}
