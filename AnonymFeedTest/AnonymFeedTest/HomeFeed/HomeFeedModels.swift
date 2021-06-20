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
        case getAfterPosts
      }
    }
    struct Response {
      enum ResponseType {
        case prepareHomeFeedModels(items: [Item])
        case showAlert(alertConfig: APIAlertConfig)
        case stopActivity
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case updateTable(cellModels: [HomeFeedTableViewCellModel])
        case showAlert(alertConfig: APIAlertConfig)
        case stopActivity
      }
    }
  }
  
}

// MARK: Models


struct HomeFeedTableViewCellModel: HomeFeedTableViewCellModelable {
    
    var id: String
    
    var userName: String?
    
    var userImageUrl: String?
    
    var contents: [Content]
    
    var stats: Stats?
    
    var isMyFavorit: Bool
    
    
}

extension HomeFeedTableViewCellModel: Hashable {
    
    static func == (lhs: HomeFeedTableViewCellModel, rhs: HomeFeedTableViewCellModel) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    
}
