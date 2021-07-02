//
//  NumberOfViewsModel.swift
//  Top Trending
//
//  Created by Quan Tran on 30/06/2021.
//

import Foundation

// MARK: - ViewData
struct ViewData: Decodable {
    var items: [Items]
}

// MARK: - Items
struct Items: Decodable {
    var statistics: NumberOfView
}

//MARK: - NumberOfView
struct NumberOfView: Decodable {
    var viewCount: String
}
