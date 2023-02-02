//
//  NewsListViewController.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import UIKit
import RxSwift
import RxCocoa

final class NewsListViewController: BaseViewController {
    private var newsDataMock: [NewsListCellModel] = [
    NewsListCellModel(
        title: "Зеркалирование GitHub-проектов в 2023 году",
        date: "02 February 2023",
        imageLink: "https://habrastorage.org/getpro/habr/upload_files/dde/4be/ac6/dde4beac6d26fca21acf850913d1f403.jpeg",
        viewed: true
    ),
    NewsListCellModel(
        title: "Этика беспилотного автомобиля и возможное решение «проблемы вагонетки»",
        date: "01 February 2023",
        imageLink: "https://habrastorage.org/getpro/habr/upload_files/cbb/367/fc7/cbb367fc700b3636e0fdb5b11bfd6edd.jpg",
        viewed: true
    ),
    NewsListCellModel(
        title: "Логистическая регрессия: подробный обзор",
        date: "02 February 2023",
        imageLink: "https://miro.medium.com/max/700/1*UgYbimgPXf6XXxMy2yqRLw.png",
        viewed: false
    ),
    NewsListCellModel(
        title: "Что такое тексел?",
        date: "02 February 2023",
        imageLink: "https://habrastorage.org/getpro/habr/upload_files/998/1e6/e69/9981e6e6909636c04bb3d8f6c7f31ade.png",
        viewed: false
    ),
    NewsListCellModel(
        title: "React, всплывающие подсказки (tooltips), для самых маленьких",
        date: "02 February 2023",
        imageLink: nil,
        viewed: true
    ),
    NewsListCellModel(
        title: "Не только Neuralink: что такое нейроинтерфейсы и кто кроме Маска разрабатывает их",
        date: "02 February 2023",
        imageLink: "https://habrastorage.org/getpro/habr/upload_files/47a/160/b7d/47a160b7da953d6218a50634cefa954e.png",
        viewed: true
    ),
    ]
    private let refreshControl = UIRefreshControl()
    
    private lazy var newsList: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collection.backgroundColor = .clear
        collection.isPagingEnabled = false
        collection.showsVerticalScrollIndicator = true
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.alwaysBounceVertical = true
        collection.refreshControl = refreshControl
        collection.register(
            NewsListCell.self,
            forCellWithReuseIdentifier: "NewsListCell"
        )
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background")
        newsList.delegate = self
        newsList.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func setupSubviews() {
        view.addSubview(newsList)
    }
    
    override func setupLayout() {
        newsList.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setupHandlers() {
        refreshControl.rx
            .controlEvent(.valueChanged)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                print("Refresh")
                owner.refreshControl.endRefreshing()
            })
            .disposed(by: self.disposeBag)
    }
}

extension NewsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsDataMock.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newsList.dequeueReusableCell(withReuseIdentifier: "NewsListCell", for: indexPath) as? NewsListCell
        else { return UICollectionViewCell() }
        
        cell.updateModel(newsDataMock[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(newsDataMock[indexPath.row].title)
    }
}
