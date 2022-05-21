//
//  NotificationsViewDataSource.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import UIKit
protocol NotificationsViewActionDelegate {
    func didTapNotification(_ notification: NotificationItemViewModel)
    func didTapMoreNotification(_ notification: NotificationItemViewModel)
}
class NotificationsViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    public var delegate: NotificationsViewActionDelegate?
    //MARK: - Properties
    private var notificationData: [NotificationItemViewModel] = []
    //MARK: -
    override init() {
        super.init()
    }
    
    func loadData(_ data: [NotificationItemViewModel], complete: (()->())?) {
        notificationData = data
        complete?()
    }
    
    func markRead(_ notificationId: String, complete: ((IndexPath?)->())?) {
        var indexPath: IndexPath?
        for (index, item) in notificationData.enumerated() {
            if notificationId == item.id{
                indexPath = IndexPath(row: index, section: 0)
                notificationData[index].markRead()
                break
            }
        }
        complete?(indexPath)
    }
    
    //MARK: - Datasource & Delegate implemention functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(NotificationTableViewCell.self, at: indexPath) else { fatalError("Cannot dequeue cell") }
        let notification: NotificationItemViewModel = notificationData[indexPath.row]
        cell.display(notification)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification: NotificationItemViewModel = notificationData[indexPath.row]
        delegate?.didTapNotification(notification)
    }
    
    
}
