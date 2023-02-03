//
//  NewsModel.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import Foundation

struct NewsModel: Model, Hashable {
    let title: String
    let date: Date
    let imageLink: URL?
    let viewed: Bool
    let content: String
    let newsLink: URL?
}
