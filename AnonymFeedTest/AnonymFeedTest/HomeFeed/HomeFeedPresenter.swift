//
//  HomeFeedPresenter.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeFeedPresentationLogic {
    func presentData(response: HomeFeed.Model.Response.ResponseType)
}

class HomeFeedPresenter: HomeFeedPresentationLogic {
    weak var viewController: HomeFeedDisplayLogic?
    
    func presentData(response: HomeFeed.Model.Response.ResponseType) {
        switch response {
        case .prepareHomeFeedModels(let apiItems):
            let models = apiItems.map(DataConverter.toHomeFeedTableCellModel(item:))
            viewController?.displayData(viewModel: .updateTable(cellModels: models))
        case .showAlert(let alertConfig):
            viewController?.displayData(viewModel: .showAlert(alertConfig: alertConfig))
        }
    }
    
}
