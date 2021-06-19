//
//  HomeFeedModels.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum HomeFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getFirstPosts
      }
    }
    struct Response {
      enum ResponseType {
        case prepareHomeFeedModels
        case showAlert(alertConfig: APIAlertConfig)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case updateTable
        case showAlert(alertConfig: APIAlertConfig)
      }
    }
  }
  
}
