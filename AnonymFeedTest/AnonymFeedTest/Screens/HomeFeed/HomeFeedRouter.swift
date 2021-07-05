//
//  HomeFeedRouter.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeFeedRoutingLogic {
    
    func openDetails(model: HomeFeedTableViewCellModel)
}

class HomeFeedRouter: NSObject, HomeFeedRoutingLogic {

  weak var viewController: HomeFeedViewController?
  
  // MARK: Routing
    func openDetails(model: HomeFeedTableViewCellModel) {
        let detailsVc = DetailsViewController(model: model)
        viewController?.navigationController?.pushViewController(detailsVc, animated: true)
    }
}
