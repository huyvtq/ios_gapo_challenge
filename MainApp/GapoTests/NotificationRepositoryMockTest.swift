//
//  NotificationRepositoryMockTest.swift
//  GapoTests
//
//  Created by HuyQuoc on 21/05/2022.
//

@testable import Gapo
typealias NotificationModel = Notification
class NotificationRepositoryTestMock: NotificationRepository {
    let notifications: [Notification]
    var keyword: String = ""
    init(notifications: [Notification]) {
        self.notifications = notifications
    }
    
    func getNotifications(_ params: GetNotificationParams, complete: ((Result<[Notification]>) -> Void)?) {
        complete?(.succeed(notifications))
    }
    
    func findNotifications(by keyword: String, complete: (([Notification]) -> Void)?) {
        self.keyword = keyword
        complete?([])
    }
    
    func markRead(_ notificationId: String, complete: ((Error?) -> Void)?) {
        
    }
    
    
}
