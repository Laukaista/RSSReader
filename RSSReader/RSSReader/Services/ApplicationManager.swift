//
//  ApplicationManager.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation

final class ApplicationManager: ApplicationFacade {
    private var newsDataMock: [NewsListCellModel] = [
        NewsListCellModel(
            title: "Зеркалирование GitHub-проектов в 2023 году",
            date: "02 February 2023",
            imageLink: URL(string: "https://habrastorage.org/getpro/habr/upload_files/dde/4be/ac6/dde4beac6d26fca21acf850913d1f403.jpeg"),
            viewed: true,
            content: ""
        ),
        NewsListCellModel(
            title: "Этика беспилотного автомобиля и возможное решение «проблемы вагонетки»",
            date: "01 February 2023",
            imageLink: nil,
            viewed: true,
            content: ""
        ),
        NewsListCellModel(
            title: "Логистическая регрессия: подробный обзор",
            date: "02 February 2023",
            imageLink: URL(string: "https://miro.medium.com/max/700/1*UgYbimgPXf6XXxMy2yqRLw.png"),
            viewed: false,
            content: ""
        ),
        NewsListCellModel(
            title: "Что такое тексел?",
            date: "02 February 2023",
            imageLink: URL(string: "https://habrastorage.org/getpro/habr/upload_files/998/1e6/e69/9981e6e6909636c04bb3d8f6c7f31ade.png"),
            viewed: false,
            content: ""
        ),
        NewsListCellModel(
            title: "React, всплывающие подсказки (tooltips), для самых маленьких",
            date: "02 February 2023",
            imageLink: nil,
            viewed: true,
            content: ""
        ),
        NewsListCellModel(
            title: "Не только Neuralink: что такое нейроинтерфейсы и кто кроме Маска разрабатывает их",
            date: "02 February 2023",
            imageLink: URL(string: "https://habrastorage.org/getpro/habr/upload_files/47a/160/b7d/47a160b7da953d6218a50634cefa954e.png"),
            viewed: true,
            content: ""
        ),
    ]
    
    func getNewsList(completion: @escaping ([NewsListCellModel]) -> Void) {
        completion(newsDataMock)
    }
    
    func getNews(index: Int, completion: @escaping (NewsListCellModel) -> Void) {
        completion(newsDataMock[index])
    }
}
