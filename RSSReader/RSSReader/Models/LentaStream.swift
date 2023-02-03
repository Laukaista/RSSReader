//
//  LentaStream.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation

enum LentaStream: String {
    case news
    case top7
    case top24
    case articles
    case columns
    case russia = "news/russia"
    case world = "news/world"
    
    var link: String {
        return "https://lenta.ru/rss/\(self.rawValue)"
    }
}
