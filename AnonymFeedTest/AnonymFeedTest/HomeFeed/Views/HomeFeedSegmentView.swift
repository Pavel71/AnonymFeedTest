//
//  HomeFeedSegmentView.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//

import UIKit


enum HomeFeedSegmentItem: String,CaseIterable {
    case mostPopular = "Популярное"
    case mostComented = "Коментируют"
    case createdAt = "Дата"
}

class HomeFeedSegmentView: UIView {
    
    private lazy var segmentController: UISegmentedControl = {
        $0.addTarget(self, action: #selector(handleSegmentAction), for: .valueChanged)
        return $0
    }(UISegmentedControl(items: HomeFeedSegmentItem.allCases.map { $0.rawValue }))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        addSubview(segmentController)
    }
    
    private func setUpConstraints() {
        segmentController.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions
extension HomeFeedSegmentView {
    @objc private func handleSegmentAction(segment: UISegmentedControl) {
        print("Handle segment Tapped")
    }
}
