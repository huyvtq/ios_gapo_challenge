//
//  NotificationRepository.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import Foundation
protocol NotificationRepository {
    func getNotifications(_ params: GetNotificationParams, complete: ((_ result: Result<[Notification]>)->Void)?)
    
    func findNotifications(by keyword: String, complete: ((_ result: [Notification])->Void)?)
    
    func markRead(_ notificationId: String, complete: ((Error?)->Void)?)
}
