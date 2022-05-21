//
//  Dependencies.swift
//  application
//
//  Created by HuyQuoc on 26/03/2022.
//

import Foundation
internal class Dependencies {
    private static let instance: Dependencies = Dependencies()
    
    //DI
    static let configuration: Configuration = instance.configuration
    static let notificationRepository: NotificationRepository = instance.internalNotificationRepository
    static let mockNotificationRepository: NotificationRepository = instance.internalMockNotificationRepository
    
    //MARK: -Internal services
    init() {
        
    }
    
    //MARK: -Internal services
    private lazy var configuration: Configuration = {
        return Configuration()
    }()
    
    private lazy var internalNotificationRepository: NotificationRepository = {
        return NotificationRepositoryImpl(api: internalNotificationAPI)
    }()
    
    private lazy var internalMockNotificationRepository: NotificationRepository = {
        return MockNotificationRepositoryImpl()
    }()
    
    private lazy var apiClient: APIClient = {
        return APIClientImpl(baseURL: configuration.baseApiUrl)
    }()
    
    private lazy var internalNotificationAPI: NotificationAPI = {
        return NotificationAPIImpl(client: apiClient)
    }()
}
