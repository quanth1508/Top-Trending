//
//  CustomTableViewCellSearch.swift
//  Top Trending
//
//  Created by Quan Tran on 29/06/2021.
//

import Foundation

// MARK: - VideoData
struct VideoData: Decodable {
    let items: [Item]
}

// MARK: - Item
struct Item: Decodable {
    let snippet: Snippet
    let id: Id
}

// MARK: - Id
struct Id: Decodable {
    let videoId: String
}

// MARK: - Snippet
struct Snippet: Decodable {
    let publishedAt: String
    let title: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let channelId: String
}

// MARK: - Thumbnails
struct Thumbnails: Decodable {
    let medium: Default

}

// MARK: - Default
struct Default: Codable {
    let url: String
}
