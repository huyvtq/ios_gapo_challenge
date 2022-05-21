//
//  UITableViewCell+Extension.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import UIKit
import Foundation
protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView{
    func register<T>(type: T.Type) where T: UITableViewCell & ReuseIdentifiable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerFromNib<T>(type: T.Type) where T: UITableViewCell & ReuseIdentifiable {
        let nibName = T.reuseIdentifier // LMAO
        let nib = UINib(nibName: nibName, bundle: Bundle(for: type))
        register(nib, forCellReuseIdentifier: nibName)
    }
    
    func dequeue<T>(_ type: T.Type, at indexPath: IndexPath) -> T? where T: UITableViewCell & ReuseIdentifiable {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}
