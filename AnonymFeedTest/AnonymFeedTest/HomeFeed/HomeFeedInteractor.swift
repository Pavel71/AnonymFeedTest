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
  var service: HomeFeedService?
  
  func makeRequest(request: HomeFeed.Model.Request.RequestType) {
    if service == nil {
      service = HomeFeedService()
    }
  }
  
}
