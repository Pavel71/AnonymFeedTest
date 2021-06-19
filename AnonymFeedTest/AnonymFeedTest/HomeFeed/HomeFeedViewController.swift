//
//  HomeFeedViewController.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeFeedDisplayLogic: class {
    func displayData(viewModel: HomeFeed.Model.ViewModel.ViewModelData)
}

class HomeFeedViewController: UIViewController, HomeFeedDisplayLogic {
    
    var interactor: HomeFeedBusinessLogic?
    var router: (NSObjectProtocol & HomeFeedRoutingLogic)?
    
    // MARK: Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = HomeFeedInteractor()
        let presenter             = HomeFeedPresenter()
        let router                = HomeFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: - UI Elements
    
    private lazy var tableView: UITableView = {
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    private lazy var segmentView = HomeFeedSegmentView()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpConstraints()
        
        interactor?.makeRequest(request: .getFirstPosts)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func displayData(viewModel: HomeFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .updateTable:
            print("Update Table")
        case .showAlert(let alertConfig):
            showAlert(apiAlertConfig: alertConfig)
        }
    }
    
}

// MARK: - Set Up Views
extension HomeFeedViewController {
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(segmentView)
        view.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        segmentView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 50))
        
        tableView.anchor(
            top: segmentView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor)
    }
}
