//
//  GithubAPIImpl.swift
//  MainApp
//
//  Created by HuyQuoc on 02/05/2022.
//

import Foundation
class NotificationAPIImpl: BaseAPIClient, NotificationAPI {
    
    func fetchNotifications(_ params: GetNotificationParams, complete: ((Result<NotificationResponse>) -> Void)?) {
        //Call api here
    }
    
    func markRead(_ notificationId: String, complete: ((Error?) -> Void)?) {
        //Call api here
    }
}
