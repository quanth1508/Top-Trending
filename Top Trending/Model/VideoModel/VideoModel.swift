//
//  VideoModel.swift
//  Top Trending
//
//  Created by Quan Tran on 29/06/2021.
//

import Foundation

struct VideoModel {
    
    var titleVideo: String
    var authorVideo: String
    var publishAt: String
    var imageVideo: String
    var idVideo: String
    var numberOfView: String
    var idChannel: String
    
    var datePublishAt: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: publishAt)
        return date
    }
    
    var numberOfViewInt: Int {
        return Int(numberOfView)!
    }
}
