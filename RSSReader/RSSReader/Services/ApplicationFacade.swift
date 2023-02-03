//
//  ApplicationFacade.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation

protocol ApplicationFacade {
    func getNewsList(completion: @escaping ([NewsListCellModel]) -> Void)
    func getNews(index: Int, completion: @escaping (NewsListCellModel) -> Void)
}
