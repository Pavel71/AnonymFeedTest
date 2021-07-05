//
//  HomeFeedViewController.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

protocol HomeFeedDisplayLogic: AnyObject {
    func displayData(viewModel: HomeFeed.Model.ViewModel.ViewModelData)
}



enum HomeFeedTableSection: CaseIterable {
    case feed
}

class HomeFeedViewController: UIViewController, HomeFeedDisplayLogic {
    
    var interactor: HomeFeedBusinessLogic?
    var router: (NSObjectProtocol & HomeFeedRoutingLogic)?
    
    // MARK: Object lifecycle
    
    var isFetching = false
    
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.startAnimating()
        $0.color = .black
        return $0
    }(UIActivityIndicatorView(style: .medium))
    
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var tableView: UITableView = {
        $0.delegate = self
        $0.estimatedRowHeight = 100
        $0.rowHeight = UITableView.automaticDimension
        $0.tableFooterView = activityIndicator
        $0.register(HomeFeedTableViewCell.self, forCellReuseIdentifier: HomeFeedTableViewCell.reusID)
        // Need to make a sevrela cells i gess or i can put all content in one cell
        $0.separatorStyle = .none
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    private lazy var segmentView = HomeFeedSegmentView()
    
    private lazy var emptyLabel: UILabel = {
        $0.text = "Данных нет!"
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .lightGray
        $0.isHidden = true
        return $0
    }(UILabel())
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpConstraints()
        
        setUpSegmentActions()
        updateSnapShot(data: [])
        fetchFirstPosts()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func displayData(viewModel: HomeFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .updateTable(let models):
            stopActivity()
            
            models.isEmpty ? setEmptyView() : hideEmptyView()
            
            updateSnapShot(data: models)
            
        case .showAlert(let alertConfig):
            activityIndicator.stopAnimating()
            showAlert(apiAlertConfig: alertConfig) {[weak self] okAction in
                self?.isFetching = false
            }
            
        case .stopActivity:
            stopActivity()
        }
    }
    
    private func setEmptyView() {
        emptyLabel.hideWithAnimation(hidden: false)
    }
    
    private func hideEmptyView() {
        emptyLabel.hideWithAnimation(hidden: true)
    }
    
}

// MARK: - Actions
extension HomeFeedViewController {
    private func fetchFirstPosts() {
        startActivity()
        interactor?.makeRequest(request: .getFirstPosts)
    }
    
    private func startActivity() {
        hideEmptyView()
        activityIndicator.startAnimating()
    }
    private func stopActivity() {
        self.isFetching = false
        activityIndicator.stopAnimating()
    }
    
    private func setUpSegmentActions() {
        segmentView.didTapSegmentAction = {[weak self] index in
            self?.startActivity()
            self?.interactor?.makeRequest(request: .getBySegmentAction(index: index))
        }

    }


}



// MARK: - Set Up Views
extension HomeFeedViewController {
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(segmentView)
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
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
        
        emptyLabel.centerInSuperview()
    }
}

// MARK: - Data Source
extension HomeFeedViewController {
    
    private func makeDataSource() -> UITableViewDiffableDataSource<HomeFeedTableSection,HomeFeedTableViewCellModel> {
        
        let dataSource = UITableViewDiffableDataSource<HomeFeedTableSection, HomeFeedTableViewCellModel>(tableView: tableView) { tableView, idx, model in
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeFeedTableViewCell.reusID) as? HomeFeedTableViewCell {
                
                cell.configure(model: model)

                return cell
            }
            return UITableViewCell()
        }
        
        return dataSource
    }
    
    
    private func updateSnapShot(data: [HomeFeedTableViewCellModel]) {
        
        var snapShot = NSDiffableDataSourceSnapshot<HomeFeedTableSection, HomeFeedTableViewCellModel>()
        snapShot.appendSections(HomeFeedTableSection.allCases)
        snapShot.appendItems(data,toSection: .feed)
        
        
        dataSource.apply(snapShot)
    }
}


// MARK: - TableView Delgate
extension HomeFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as?  HomeFeedTableViewCell,
           let model = dataSource.itemIdentifier(for: indexPath) {
            cell.stopPlayer()
            router?.openDetails(model: model)
        }
        print("Select Cell",indexPath.row)
    }
    
    // MARK: - Scroll View

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)

        // if bottom and scroll down
        if scrollView.isNearBottomEdge(edgeOffset: 0),
           translation.y < 0 {

            if  self.isFetching == false {
                startActivity()
                self.isFetching = true

                interactor?.makeRequest(request: .getAfterPosts)
            }

        }
    }
    
}
