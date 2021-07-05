//
//  UIstackView+Extension.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 05.07.2021.
//

import UIKit



extension UIStackView {
    
    public func embedInVStack(aligment: Alignment) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = aligment
        
        stack.addArrangedSubview(self)
        
        return stack
    }
    
    
    public func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    public func addSpacing(spacing: CGFloat) {
        guard let view = arrangedSubviews.last else {
            return
        }
        
        setCustomSpacing(spacing, after: view)
    }
}
