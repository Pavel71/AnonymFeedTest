//
//  DetailsInteractor.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 05.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailsBusinessLogic {
  func makeRequest(request: Details.Model.Request.RequestType)
}

class DetailsInteractor: DetailsBusinessLogic {

  var presenter: DetailsPresentationLogic?
  var service: DetailsService?
  
  func makeRequest(request: Details.Model.Request.RequestType) {
    if service == nil {
      service = DetailsService()
    }
  }
  
}
