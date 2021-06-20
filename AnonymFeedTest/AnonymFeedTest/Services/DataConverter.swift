//
//  DataConverter.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//

import Foundation


class DataConverter {
    
    
    
    static func toHomeFeedTableCellModel(item: Item) -> HomeFeedTableViewCellModel {
        let author = item.author
        return .init(
            id: item.id ?? UUID().uuidString,
            userName: author?.name ?? "",
            userImageUrl: author?.banner?.data?.extraSmall?.url ?? "",
            contents: item.contents ?? [],
            stats: item.stats,
            isMyFavorit: item.isMyFavorite ?? false)
    }
}
