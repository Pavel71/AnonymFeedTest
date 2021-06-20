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
    
    
    var tableData: [HomeFeedTableViewCellModel] = []
    
    func presentData(response: HomeFeed.Model.Response.ResponseType) {
        switch response {
        case .prepareHomeFeedModels(let apiItems):
            tableData.append(contentsOf: apiItems.map(DataConverter.toHomeFeedTableCellModel(item:)))
            viewController?.displayData(viewModel: .updateTable(cellModels: tableData))
        case .showAlert(let alertConfig):
            viewController?.displayData(viewModel: .showAlert(alertConfig: alertConfig))
        case .stopActivity:
            viewController?.displayData(viewModel: .stopActivity)
        case .clearData:
            tableData.removeAll()
        }
    }
    
}
