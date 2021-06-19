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
  
  }
  
}
