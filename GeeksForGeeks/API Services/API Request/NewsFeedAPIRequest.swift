//
//  NewsFeedAPIRequest.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import Foundation

class NewsFeedAPIRequest {
    static func getNewsFeedRequest()-> APIRequest<NewsFeed?>{
        let url = "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"
        return APIRequest<NewsFeed?>(url: url)
    }
}
