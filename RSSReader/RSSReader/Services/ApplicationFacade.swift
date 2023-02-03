//
//  ApplicationFacade.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation
import RxSwift

protocol ApplicationFacade {
    var models: [NewsModel] { get }
    var listNeedsUpdate: PublishSubject<Void> { get }
    var errorOccured: PublishSubject<String> { get }
    func updateNewsList()
    func getNews(index: Int, completion: @escaping (NewsModel) -> Void)
}
