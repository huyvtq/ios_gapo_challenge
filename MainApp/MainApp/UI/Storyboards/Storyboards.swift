//
//  Storyboards.swift
//  application
//
//  Created by HuyQuoc on 30/04/2022.
//

import UIKit
class Storyboards {
    private static let instance: Storyboards = Storyboards()
    
    public static let main: UIStoryboard = instance.mainStoryboard
    
    private lazy var mainStoryboard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: nil)
    }()
}

extension UIStoryboard{
    func instantiateViewController<T>(type: T.Type) -> T where T: UIViewController {
        return self.instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
    
    func instantiateViewController<T>(type: T.Type, navigator: Navigator? = nil) -> T where T: BaseViewController {
        let vc = self.instantiateViewController(withIdentifier: String(describing: type)) as! T
        vc.navigator = navigator
        return vc
    }
}
