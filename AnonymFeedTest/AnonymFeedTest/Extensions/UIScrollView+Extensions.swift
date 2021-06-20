//
//  UIScrollView+Extensions.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 20.06.2021.
//

import UIKit

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
