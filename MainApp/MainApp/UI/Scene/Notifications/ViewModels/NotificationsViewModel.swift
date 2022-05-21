//
//  NotificationsViewModel.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//
import RxSwift

class NotificationsViewModel {
    //MARK: - Properties
    let disposeBag: DisposeBag = DisposeBag()
    let notificationRepository: NotificationRepository
    let searchDebounceMiliseconds: Int = 200
    //MARK: - Outputs
    //Emit data notifications
    private let onLoadNotificationSubject = PublishSubject<[NotificationItemViewModel]>()
    var onLoadNotifications: Observable<[NotificationItemViewModel]> { onLoadNotificationSubject.asObservable() }
    
    //Emit error to view
    private let onErrorSubject = PublishSubject<Error>()
    var onError: Observable<Error> { onErrorSubject.asObservable() }
    
    //Emit show/hide loading view
    private let onLoadingSubject = PublishSubject<Bool>()
    var onLoading: Observable<Bool> { onLoadingSubject.asObservable() }
    
    //Emit show/hide loading view
    private let onMarkedSubject = PublishSubject<String>()
    var onMarked: Observable<String> { onMarkedSubject.asObservable() }
    
    //MARK: - Inputs
    private let onSearchSubject = PublishSubject<String>()
    var onSearch: AnyObserver<String> { onSearchSubject.asObserver() }
    
    private let onMarkReadSubject = PublishSubject<NotificationItemViewModel>()
    var onMarkRead: AnyObserver<NotificationItemViewModel> { onMarkReadSubject.asObserver() }
    
    //MARK: -
    init(notificationRepository: NotificationRepository) {
        self.notificationRepository = notificationRepository
    }
    
    func load() {
        loadNotifications()
        
        //subscribe events
        onSearchSubject
            .distinctUntilChanged()
            .debounce(RxTimeInterval.milliseconds(searchDebounceMiliseconds), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] keyword in
                self?.searchNotification(by: keyword)
            }).disposed(by: disposeBag)
        
        onMarkReadSubject.subscribe(onNext: { [weak self] notification in
            self?.markRead(notification)
        }).disposed(by: disposeBag)
    }
    
    private func loadNotifications(){
        //Emit show loading
        self.onLoadingSubject.onNext(true)
        notificationRepository.getNotifications(GetNotificationParams(keyword: "", pageNo: 1)) { [weak self] result in
            //Emit hide loading
            self?.onLoadingSubject.onNext(false)
            //Handle result
            switch result{
            case .succeed(let notifications):
                let transformer: NotificationItemViewModelTransformer = NotificationItemViewModelTransformer()
                let itemViewModels: [NotificationItemViewModel] = notifications.map {
                    return transformer.transform($0)
                }
                self?.onLoadNotificationSubject.onNext(itemViewModels)
            case .failed(let error):
                log.error(error)
                self?.onErrorSubject.onNext(error)
            }
        }
    }
    
    private func searchNotification(by keyword: String){
        //Emit show loading
        self.onLoadingSubject.onNext(true)
        notificationRepository.findNotifications(by: keyword) { [weak self] result in
            //Emit hide loading
            self?.onLoadingSubject.onNext(false)
            let transformer: NotificationItemViewModelTransformer = NotificationItemViewModelTransformer()
            let itemViewModels: [NotificationItemViewModel] = result.map {
                return transformer.transform($0)
            }
            self?.onLoadNotificationSubject.onNext(itemViewModels)
        }
    }
    
    private func markRead(_ notification: NotificationItemViewModel){
        notificationRepository.markRead(notification.id) { [weak self] error in
            guard error == nil else {
                log.error(error)
                return
            }
            self?.onMarkedSubject.onNext(notification.id)
        }
    }
}
