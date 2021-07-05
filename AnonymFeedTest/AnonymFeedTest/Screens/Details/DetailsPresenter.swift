//
//  DetailsPresenter.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 05.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailsPresentationLogic {
  func presentData(response: Details.Model.Response.ResponseType)
}

class DetailsPresenter: DetailsPresentationLogic {
  weak var viewController: DetailsDisplayLogic?
  
  func presentData(response: Details.Model.Response.ResponseType) {
  
  }
  
}
