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
    private var newsModels = [NewsListCellModel]()
    private let appManager: ApplicationFacade
    
    init(title: String? = nil, manager: ApplicationFacade) {
        appManager = manager
        super.init(title: title)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let topLogo: UIImageView = {
        let image = UIImage(named: "LentaLogo")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
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
        
        updateNewsList()
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
        view.addSubview(topLogo)
        view.addSubview(newsList)
    }
    
    override func setupLayout() {
        topLogo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(20.0)
            make.width.equalTo(120.0)
        }
        
        newsList.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(topLogo.snp.bottom).inset(-20.0)
        }
    }
    
    override func setupHandlers() {
        refreshControl.rx
            .controlEvent(.valueChanged)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.updateNewsList()
                owner.refreshControl.endRefreshing()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func updateNewsList() {
        appManager.getNewsList { [weak self] models in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.newsModels = models
                self.newsList.reloadData()
            }
        }
    }
}

extension NewsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newsList.dequeueReusableCell(withReuseIdentifier: "NewsListCell", for: indexPath) as? NewsListCell
        else { return UICollectionViewCell() }
        
        cell.updateModel(newsModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        appManager.getNews(index: indexPath.row) { [weak self] model in
            guard let self else { return }
            
            let controller = NewsScreenViewController(title: "Lenta.ru", model: model)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
