//
//  DetailsViewController.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 05.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogic: class {
    func displayData(viewModel: Details.Model.ViewModel.ViewModelData)
}

class DetailsViewController: VstackController, DetailsDisplayLogic {
    
    // MARK: - UIElemetns
    
    private lazy var userView = DetailsUserView()
    private lazy var postStatsView = DetailsPostStatsView()
    private lazy var postContentView = DetailsContentView()
    
    
    var interactor: DetailsBusinessLogic?
    var router: (NSObjectProtocol & DetailsRoutingLogic)?
    
    // MARK: Object lifecycle
    let model: HomeFeedTableViewCellModel
    init(model: HomeFeedTableViewCellModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = DetailsInteractor()
        let presenter             = DetailsPresenter()
        let router                = DetailsRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }

    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
        configureModel(model: model)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    func displayData(viewModel: Details.Model.ViewModel.ViewModelData) {
        
    }
    
    private func configureStackView() {
        view.backgroundColor = .white
        contentView.backgroundColor = .white
        addView(userView)
        addSpacer(20)
        addView(postContentView)
        addView(postStatsView)
    }
    
}


extension DetailsViewController {
    
    func configureModel(model: HomeFeedTableViewCellModel) {
        
        userView.configure(userImageUrl: model.userImageUrl ?? "", userName: model.userName ?? "")
        postContentView.configure(contents: model.contents)
        postStatsView.configure(stats: model.stats)
    }
}
