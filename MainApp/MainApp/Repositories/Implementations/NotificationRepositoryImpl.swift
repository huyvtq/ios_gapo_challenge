//
//  NotificationRepositoryImpl.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import Foundation
class NotificationRepositoryImpl: NotificationRepository {
    //MARK: - Properties
    let api: NotificationAPI
    
    //MARK: -
    init(api: NotificationAPI) {
        self.api = api
    }
    
    func getNotifications(_ params: GetNotificationParams, complete: ((_ result: Result<[Notification]>)->Void)?) {
        api.fetchNotifications(params) { result in
            switch result{
            case .succeed(let response):
                complete?(.succeed(response.data))
            case .failed(let error):
                complete?(.failed(error))
            }
        }
    }
    
    func findNotifications(by keyword: String, complete: (([Notification]) -> Void)?) {
        getNotifications(GetNotificationParams(keyword: keyword, pageNo: 1)) { result in
            switch result{
            case .succeed(let data):
                complete?(data)
            case .failed:
                complete?([])
            }
        }
    }
    
    func markRead(_ notificationId: String, complete: ((Error?) -> Void)?) {
        api.markRead(notificationId, complete: complete)
    }
}
