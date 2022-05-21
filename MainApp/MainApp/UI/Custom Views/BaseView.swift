//
//  BaseView.swift
//  MainApp
//
//  Created by HuyQuoc on 12/05/2022.
//

import UIKit

open class BaseView: UIView {
    
    open func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
    }
    
}
