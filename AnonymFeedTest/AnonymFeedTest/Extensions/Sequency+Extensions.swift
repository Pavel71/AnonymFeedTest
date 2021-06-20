//
//  Sequency+Extensions.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 20.06.2021.
//

import Foundation

extension Array where Element: Hashable {

  // Remove first collection element that is equal to the given `object`:
  mutating func remove(object: Element) {
      guard let index = firstIndex(of: object) else { return }
      remove(at: index)
  }

    var unique: [Element] {
        return Array(Set(self))
    }
    
    
    subscript (safe index: Index) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
    
}
