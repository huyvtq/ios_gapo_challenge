//
//  MockNotificationRepositoryImpl.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import Foundation
class MockNotificationRepositoryImpl: NotificationRepository {
    //MARK: - Properties
    let codableParser: CodableParseHelper = CodableParseHelper()
    var notifications: [Notification] = []
    let notificationQueue = DispatchQueue(label: "MockNotificationRepositoryImpl")
    
    //MARK: -
    init() {
    }
    
    func getNotifications(_ params: GetNotificationParams, complete: ((Result<[Notification]>) -> Void)?) {
        notificationQueue.asyncAfter(deadline: DispatchTime.now() + 1) {
            do{
                let notiUrl = Bundle.main.url(forResource: "mock_noti", withExtension: "json")!
                let data = try Data(contentsOf: notiUrl)
                let notiResponse: NotificationResponse = try self.codableParser.parse(data: data)
                self.notifications = notiResponse.data
                DispatchQueue.main.async {
                    complete?(.succeed(notiResponse.data))
                }
            }catch let error{
                log.error(error)
                complete?(.failed(error))
            }
        }
    }
    
    func findNotifications(by keyword: String, complete: (([Notification]) -> Void)?) {
        log.debug("Search notifications with keyword: \(keyword)")
        guard !keyword.isBlank else {
            complete?(self.notifications)
            return
        }
        var results: [Notification] = []
        results = notifications.filter({ (noti) -> Bool in
            return noti.message.text.lowercased().removeDistrict()
                .contains(keyword.lowercased().removeDistrict())
        })
        complete?(results)
    }
    
    func markRead(_ notificationId: String, complete: ((Error?) -> Void)?) {
        outerLoop: for (index, noti) in notifications.enumerated() {
            if noti.id == notificationId{
                notifications[index].updateStatus(Notification.Status.read)
                complete?(nil)
                break outerLoop
            }
        }
    }
}
