//
//  NotificationsViewController.swift
//  MainApp
//
//  Created by HuyQuoc on 20/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
//MARK: - NotificationsViewController
class NotificationsViewController: BaseViewController {
    
    enum State {
        case searching
        case normal
    }
    
    //MARK: - Subviews
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchButton: RippleButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var closeSearchButton: UIButton!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var state: State = State.normal{
        didSet { showUI(for: state) }
    }
    
    //MARK: - Properties
    let disposeBag: DisposeBag = DisposeBag()
    private var viewModel: NotificationsViewModel! = nil
    private var dataSource: NotificationsViewDataSource?
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindEvents()
        bindData()
    }
    
    public func bindVM(_ viewModel: NotificationsViewModel){
        self.viewModel = viewModel
    }
    
    private func setupUI() {
        state = State.normal
        titleLabel.text = L10n.textTitleNotification
        searchButton.cornerRadius = searchButton.frame.height/2
        //Tableview
        dataSource = NotificationsViewDataSource()
        dataSource?.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        //Search textfield
        searchTextField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = Asset.Assets.icSearchTextField.image
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        imageView.center = leftView.center
        leftView.addSubview(imageView)
        searchTextField.leftView = leftView
    }
    
    private func bindData() {
        viewModel.onLoading.subscribe(onNext: { [weak self] isLoading in
            self?.showLoadingView(isLoading)
        }).disposed(by: disposeBag)
        
        viewModel.onError.subscribe(onNext: { [weak self] error in
            self?.showError(error)
        }).disposed(by: disposeBag)
        
        viewModel.onLoadNotifications.subscribe(onNext: { [weak self] notifications in
            self?.dataSource?.loadData(notifications, complete: {
                self?.tableView.reloadData()
            })
        }).disposed(by: disposeBag)
        
        viewModel.onMarked.subscribe(onNext: { [weak self] notificationId in
            self?.dataSource?.markRead(notificationId, complete: { indexPath in
                guard let ip = indexPath else {
                    return
                }
                self?.tableView.reloadRows(at: [ip], with: UITableView.RowAnimation.none)
            })
        }).disposed(by: disposeBag)
        
        viewModel.load()
    }
    
    private func bindEvents() {
        searchButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.state = State.searching
        }).disposed(by: disposeBag)
        
        closeSearchButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.state = State.normal
            self?.searchTextField.text = ""
            self?.viewModel.onSearch.onNext("")
        }).disposed(by: disposeBag)
        
        searchTextField.rx.text.orEmpty
            .bind(to: viewModel.onSearch)
            .disposed(by: disposeBag)
    }
    
    private func showLoadingView(_ isShow: Bool){
        if isShow{
            loadingActivityIndicator.isHidden = false
            loadingActivityIndicator.startAnimating()
        }else{
            loadingActivityIndicator.isHidden = true
            loadingActivityIndicator.stopAnimating()
        }
    }
    
    private func showError(_ error: Error){
        log.error(error.localizedDescription)
    }
    
    private func showUI(for state: State){
        switch state{
        case State.searching:
            searchView.isHidden = false
            searchTextField.becomeFirstResponder()
        case State.normal:
            searchView.isHidden = true
            searchTextField.endEditing(true)
        }
    }
}

//MARK: - NotificationsViewController+NotificationsViewActionDelegate
extension NotificationsViewController: NotificationsViewActionDelegate{
    func didTapNotification(_ notification: NotificationItemViewModel) {
        if !notification.isRead{
            viewModel.onMarkRead.onNext(notification)
        }
        let openParams = Navigator.OpenNotificationDetailParams()
        navigator?.pushToNotificationDetails(openParams)
    }
    
    func didTapMoreNotification(_ notification: NotificationItemViewModel) {
        
    }
}
