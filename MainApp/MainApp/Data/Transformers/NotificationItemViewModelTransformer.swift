//
//  NotificationItemViewModelTransformer.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import Foundation
class NotificationItemViewModelTransformer: NSObject {
    
    func transform(_ data: Notification) -> NotificationItemViewModel {
        let isRead: Bool = (data.status == .read) ? true : false
        let highlights: [(offset: Int, length: Int)] = data.message.highlights.map{ (offset: $0.offset, length: $0.length) }
        
        return NotificationItemViewModel(id: data.id,
                                         title: data.message.text,
                                         image: data.image,
                                         icon: data.icon,
                                         time: Date(timeIntervalSince1970: TimeInterval(data.createdAt)),
                                         highlights: highlights,
                                         isRead: isRead)
    }
}
