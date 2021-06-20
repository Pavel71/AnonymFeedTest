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
    
    private var apiRequest = ApiRequest()
    
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
            api?.fetch(from: .first(APIConstants.feedItemsCount), completion: {[weak self]
                result in
                switch result {
                case .failure(let error):
                    
                    self?.showAlert(alertConfig: .init(title: "First Error", message: error.localizedDescription))
                case .success(let apiData):
        
                    self?.apiRequest.cursor = apiData.data.cursor
                    self?.presenter?.presentData(response: .prepareHomeFeedModels(items: apiData.data.items))
                }
            })
        }
    }
    
    
    private func showAlert(alertConfig: APIAlertConfig) {
        presenter?.presentData(response: .showAlert(alertConfig: alertConfig))
    }
}
