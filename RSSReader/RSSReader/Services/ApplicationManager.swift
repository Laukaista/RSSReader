//
//  ApplicationManager.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation
import RxSwift

final class ApplicationManager: ApplicationFacade {
    private let disposeBag = DisposeBag()
    
    var listNeedsUpdate = PublishSubject<Void>()
    var errorOccured = PublishSubject<String>()
    var models = [NewsModel]()
    
    private let rssService: RSSService
    private let storageService: StorageServiceProtocol
    
    init(rssService: RSSService, storageService: StorageService) {
        self.rssService = rssService
        self.storageService = storageService
        
        let isFirstLainch = !UserDefaults.standard.bool(forKey: "rssApp_is_first_launch")
        
        if isFirstLainch {
            updateNewsList()
            UserDefaults.standard.set(false, forKey: "rssApp_is_first_launch")
        } else {
            loadNewsList()
        }
    }
    
    private func loadNewsList() {
        storageService.readEntities { [weak self] news in
            guard let self else { return }
            
            self.models = news.compactMap({ news in
                return NewsModel(
                    title: news.title,
                    date: news.date,
                    imageLink: URL(string: news.imageLink ?? ""),
                    viewed: news.isViewed,
                    content: news.description
                )
            })
        }
    }
    
    func updateNewsList() {
        rssService.parseFeed(link: LentaStream.news.link) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let items):
                let internalModels = items.map { item in
                    return NewsModel(
                        title: item.title,
                        date: Date.dateFromRss(string: item.pubDate) ?? Date(),
                        imageLink: URL(string: item.imageLink),
                        viewed: false,
                        content: item.description
                    )
                }
                
                let updatedModels = Array(Set(internalModels).subtracting(self.models))
                self.storageService.createEntity(from: updatedModels) { _ in
                    self.models = updatedModels
                    self.listNeedsUpdate.onNext(())
                }
            case .failure(let error):
                self.errorOccured.onNext(error.localizedDescription)
            }
        }
    }
    
    func getNews(index: Int, completion: @escaping (NewsModel) -> Void) {
        let news = models[index]
        let newModel = NewsModel(
            title: news.title,
            date: news.date,
            imageLink: news.imageLink,
            viewed: true,
            content: news.content
        )
        models[index] = newModel
        storageService.updateEntity(from: newModel) { [weak self] _ in
            guard let self else { return }
            completion(self.models[index])
        }
    }
}
