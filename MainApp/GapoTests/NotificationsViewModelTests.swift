//
//  NotificationsViewModelTests.swift
//  GapoTests
//
//  Created by HuyQuoc on 21/05/2022.
//

import XCTest
import RxSwift
@testable import Gapo

class NotificationsViewModelTests: XCTestCase {
    
    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: NotificationsViewModel! = nil
    
    override class func setUp() {
    }
    
    func testGetNotificationFromMockJsonFile() throws {
        var testError: Error?
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .millisecondsSince1970
            
            let notiUrl = Bundle.main.url(forResource: "mock_noti", withExtension: "json")!
            let data = try Data(contentsOf: notiUrl)
            let _: NotificationResponse = try decoder.decode(NotificationResponse.self, from: data)
        }catch let error {
            testError = error
        }
        
        XCTAssertNil(testError)
    }
    
    func testNofificationsEmpty()  {
        let repository: NotificationRepository = NotificationRepositoryTestMock(notifications: [])
        viewModel = NotificationsViewModel(notificationRepository: repository)
        
        viewModel.onLoadNotifications.subscribe(onNext: { notifications in
            XCTAssertTrue(notifications.count == 0)
        }).disposed(by: disposeBag)
        
        viewModel.load()
    }
    
    func testNofificationsNotEmpty()  {
        let notifications: [NotificationModel] = getNotificationFromJsonFile()
        let repository: NotificationRepository = NotificationRepositoryTestMock(notifications: notifications)
        viewModel = NotificationsViewModel(notificationRepository: repository)
        
        viewModel.onLoadNotifications.subscribe(onNext: { notifications in
            XCTAssertTrue(notifications.count > 0)
        }).disposed(by: disposeBag)
        
        viewModel.load()
    }
    
    func testInputKeywordEqualParam(){
        let repository: NotificationRepositoryTestMock = NotificationRepositoryTestMock(notifications: [])
        viewModel = NotificationsViewModel(notificationRepository: repository)
        
        let inputKeyword: String = "Hello"
        viewModel.searchNotification(by: inputKeyword)
        XCTAssertEqual(inputKeyword, repository.keyword)
    }
    
    func testInputKeywordNotEqualParam(){
        let repository: NotificationRepositoryTestMock = NotificationRepositoryTestMock(notifications: [])
        viewModel = NotificationsViewModel(notificationRepository: repository)
        
        let inputKeyword: String = "Hello"
        viewModel.searchNotification(by: "Bye")
        XCTAssertNotEqual(inputKeyword, repository.keyword)
    }
    
    func getNotificationFromJsonFile() -> [NotificationModel] {
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .millisecondsSince1970
            
            let notiUrl = Bundle.main.url(forResource: "mock_noti", withExtension: "json")!
            let data = try Data(contentsOf: notiUrl)
            let notiResponse: NotificationResponse = try decoder.decode(NotificationResponse.self, from: data)
            return notiResponse.data
        }catch _{
            return []
        }
    }
    
    override class func tearDown() {
        print("Finished a test.")
    }

}
