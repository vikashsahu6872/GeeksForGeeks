//
//  NewsFeed.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import Foundation

// MARK: - NewsFeed
struct NewsFeed: Codable {
    let status: String
    let feed: Feed
    let items: [Item]
}

// MARK: - Feed
struct Feed: Codable {
    let url: String
    let title: String
    let link: String
    let author, feedDescription: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case url, title, link, author
        case feedDescription = "description"
        case image
    }
}

// MARK: - Item
struct Item: Codable,Hashable {
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return (lhs.title == rhs.title && lhs.pubDate == rhs.pubDate) ? true : false
    }
    
    let title, pubDate: String
    let link, guid: String
    let author: String
    let thumbnail: String
    let itemDescription, content: String
    let enclosure: Enclosure
    let categories: [String]

    enum CodingKeys: String, CodingKey {
        case title, pubDate, link, guid, author, thumbnail
        case itemDescription = "description"
        case content, enclosure, categories
    }
}

// MARK: - Enclosure
struct Enclosure: Codable,Hashable {
    let link: String
    let type: String
    let thumbnail: String
}

