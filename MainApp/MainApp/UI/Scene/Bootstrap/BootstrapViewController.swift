//
//  BootstrapViewController.swift
//  application
//
//  Created by HuyQuoc on 30/04/2022.
//

import UIKit

class BootstrapViewController: BaseNavigationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            self?.gotoNotificationScreen()
        }
    }
    
    func gotoNotificationScreen() {
        let navigator: Navigator = Navigator(navigationController: self)
        
        let notificationVC: NotificationsViewController = Storyboards.main.instantiateViewController(type: NotificationsViewController.self, navigator: navigator)
        
//        let notificationRepository = Dependencies.notificationRepository //Get data from sever-site
        let mockNotificationRepository = Dependencies.mockNotificationRepository //Mock data
        let viewModel: NotificationsViewModel = NotificationsViewModel(notificationRepository: mockNotificationRepository)
        
        notificationVC.bindVM(viewModel)
        viewControllers = [notificationVC]
    }

}
