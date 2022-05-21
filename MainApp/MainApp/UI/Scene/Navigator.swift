//
//  Navigator.swift
//  MainApp
//
//  Created by HuyQuoc on 12/05/2022.
//

import UIKit
//MARK: - Navigator
internal class Navigator {
    public typealias TransitionCompletion = () -> ()
    //MARK: - Properties
    private let navigationController: UINavigationController
    
    //MARK: -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Navigate functions
    func back(_ animated: Bool = true, completion: TransitionCompletion? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock { completion?() }
        navigationController.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func backToRoot(_ animated: Bool = true, completion: TransitionCompletion? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock { completion?() }
        navigationController.popToRootViewController(animated: animated)
        CATransaction.commit()
    }
    
    func backTo(_ vc: UIViewController, animated: Bool = true, completion: TransitionCompletion?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock { completion?() }
        navigationController.popToViewController(vc, animated: true)
        CATransaction.commit()
    }
    
    func dismiss(_ animated: Bool = true, completion: TransitionCompletion?) {
        navigationController.dismiss(animated: animated) {
            completion?()
        }
    }
    
    func pushToNotificationDetails(_ params: OpenNotificationDetailParams) {
        let vc: NotificationDetailsViewController = Storyboards.main.instantiateViewController(type: NotificationDetailsViewController.self, navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
