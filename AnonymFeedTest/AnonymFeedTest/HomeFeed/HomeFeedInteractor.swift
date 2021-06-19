//
//  HomeFeedInteractor.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeFeedBusinessLogic {
  func makeRequest(request: HomeFeed.Model.Request.RequestType)
}

class HomeFeedInteractor: HomeFeedBusinessLogic {

  var presenter: HomeFeedPresentationLogic?
  var api: APIService?
    
    init() {
        api = ServiceLocator.shared.getService()
    }
  
    func makeRequest(request: HomeFeed.Model.Request.RequestType) {
        getAPIRequests(request: request)
    }
  
}

// MARK: Api
extension HomeFeedInteractor {
    
    private func getAPIRequests(request: HomeFeed.Model.Request.RequestType) {
        switch request {
        case .getFirstPosts:
            print("Get Api Request")
            api?.fetch(from: .first(APIConstants.feedItemsCount), completion: {[weak self] result in
                
                switch result {
                case .failure(let error):
                    print("Error show alert")
                    self?.showAlert(alertConfig: .init(title: "First Error", message: error.localizedDescription))
                case .success(let apiData):
                    print("Api Model data",apiData)
                    print("Count",apiData.data.items.count)
                    
                    self?.presenter?.presentData(response: .prepareHomeFeedModels)
                }
            })
        }
    }
    
    
    private func showAlert(alertConfig: APIAlertConfig) {
        presenter?.presentData(response: .showAlert(alertConfig: alertConfig))
    }
}
