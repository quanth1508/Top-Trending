//
//  ChannelData.swift
//  Top Trending
//
//  Created by Quan Tran on 01/07/2021.
//

import Foundation

// MARK: - ChannelData
struct ChannelData: Decodable {
    let items: [Itemss]
}

// MARK: - Item
struct Itemss: Decodable {
    let snippet: Snippetss
}

// MARK: - Snippet
struct Snippetss: Decodable {
    let thumbnails: Thumbnailss
}

// MARK: - Thumbnails
struct Thumbnailss: Decodable {
    let medium: Defaultss

}

// MARK: - Default
struct Defaultss: Decodable {
    let url: String
}
