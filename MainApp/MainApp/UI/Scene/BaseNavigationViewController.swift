//
//  BaseNavigationViewController.swift
//  application
//
//  Created by HuyQuoc on 30/04/2022.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
}
