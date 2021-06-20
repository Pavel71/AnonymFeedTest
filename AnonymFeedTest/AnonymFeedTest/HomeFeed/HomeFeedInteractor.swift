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
          fetch(endPoint: .first(APIConstants.feedItemsCount))
            
        case .getAfterPosts:
            
            if let cursore = apiRequest.cursor {
                print("Get After Posts",cursore)
                fetch(endPoint: .after(cursore))
            } else {
                presenter?.presentData(response: .stopActivity)
            }
            
            
        case .getBySegmentAction(let index):
            if let action = HomeFeedSegmentItem.allCases[safe: index] {
                // Here need clear presenter data
                presenter?.presentData(response: .clearData)
                fetch(endPoint: .orderBy(action.rawValue))
            }
            
        }
    }
    
    private func fetch(endPoint: Endpoint) {
        api?.fetch(from: endPoint , completion: {[weak self]
            result in
            switch result {
            case .failure(let error):
                
                self?.showAlert(alertConfig: .init(title: "Some thing went wrong", message: error.localizedDescription))
            case .success(let apiData):
                
                if let data = apiData.data {
                    self?.apiRequest.cursor = data.cursor
                    self?.presenter?.presentData(response: .prepareHomeFeedModels(items: data.items ?? []))
                }
                
            }
        })
    }
    
    
    private func showAlert(alertConfig: APIAlertConfig) {
        presenter?.presentData(response: .showAlert(alertConfig: alertConfig))
    }
}
