//
//  UIViewController+Extensions.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//

import UIKit
// MARK: - Show Alert
extension UIViewController {
    func showAlert(apiAlertConfig: APIAlertConfig) {
      
        let alertControlelr = UIAlertController(title: apiAlertConfig.title, message: apiAlertConfig.message, preferredStyle: .alert)
        
      let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
      
      alertControlelr.addAction(alertAction)
      present(alertControlelr, animated: true, completion: nil)
    }
}
