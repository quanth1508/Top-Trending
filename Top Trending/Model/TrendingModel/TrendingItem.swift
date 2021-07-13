//
//  TrendingModel.swift
//  Top Trending
//
//  Created by Quan Tran on 28/06/2021.
//

import Foundation

//MARK: - Trending Item

struct TrendingItem {
    
    var title: String
    var approx_traffic: String
    var picture: String
    var data: Data? 
    var itemTitle: String
    var itemUrl: String
    var pubDate: String
    
    var datePubDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.date(from: pubDate)
        return date
    }

}


