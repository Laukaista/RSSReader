//
//  NewsListCellModel.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import Foundation

struct NewsListCellModel: Model {
    let title: String
    let date: String
    let imageLink: URL?
    let viewed: Bool
    let content: String
}
