//
//  NotificationAPI.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import Foundation
protocol NotificationAPI {
    func fetchNotifications(_ params: GetNotificationParams, complete: ((_ result: Result<NotificationResponse>)->Void)?)
    
    func markRead(_ notificationId: String, complete: ((Error?)->Void)?)
}
