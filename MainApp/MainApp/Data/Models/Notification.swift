//
//  Notification.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import Foundation
// MARK: - Notification
struct Notification: Codable {
    let id, type, title: String
    let message: Message
    let image: String
    let icon: String
    var status: Status
    let subscription: Subscription?
    let readAt, createdAt, updatedAt, receivedAt: Int
    let imageThumb: String
    let animation, tracking, subjectName: String?
    let isSubscribed: Bool
    
    mutating func updateStatus(_ status: Status){
        self.status = status
    }
    
    // MARK: - Status
    enum Status: String, Codable {
        case read = "read"
        case unread = "unread"
    }
    
    // MARK: - Message
    struct Message: Codable {
        let text: String
        let highlights: [Highlight]
    }
    
    // MARK: - Highlight
    struct Highlight: Codable {
        let offset, length: Int
    }
    
    // MARK: - Subscription
    struct Subscription: Codable {
        let targetID, targetType, targetName: String?
        let level: Int?

        enum CodingKeys: String, CodingKey {
            case targetID = "targetId"
            case targetType, targetName, level
        }
    }
}

struct NotificationItemViewModel {
    let id: String
    let title: String
    let image: String
    let icon: String
    let time: Date
    let highlights: [(offset: Int, length: Int)]
    var isRead: Bool
    
    mutating func markRead(){
        self.isRead = true
    }
}

