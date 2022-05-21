//
//  NotificationDetailsViewController.swift
//  MainApp
//
//  Created by HuyQuoc on 21/05/2022.
//

import UIKit
class NotificationDetailsViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigator?.back()
    }
}
