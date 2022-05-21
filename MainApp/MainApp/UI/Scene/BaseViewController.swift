//
//  BaseViewController.swift
//  MainApp
//
//  Created by HuyQuoc on 12/05/2022.
//

import UIKit
protocol Navigable {
    var navigator: Navigator? { get }
}

class BaseViewController: UIViewController, Navigable {
    typealias ConfirmCompletion = (_ yes: Bool)->()
    //MARK: - Properties
    var navigator: Navigator?
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public func showAlertConfirm(title: String, message: String, yes: String, no: String, completion: @escaping(ConfirmCompletion)){
        let actionController = UIAlertController(title: title,
                                                 message: message, preferredStyle: .alert)

        let yesAction = UIAlertAction(title: yes, style: .destructive) { _ in
            completion(true)
        }
        actionController.addAction(yesAction)

        let noAction = UIAlertAction(title: no, style: .cancel) { action in
            completion(false)
        }
        actionController.addAction(noAction)

        present(actionController, animated: true, completion: nil)
    }

}
