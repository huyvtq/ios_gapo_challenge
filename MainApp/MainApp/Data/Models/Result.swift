//
//  Result.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import Foundation
enum Result<T> {
    case succeed(T)
    case failed(Error)
}
