//
//  NewsScreenViewController.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import UIKit
import Kingfisher

final class NewsScreenViewController: ViewController<NewsModel> {
    private let image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.font = .style(.title)
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    private let newsDate: UILabel = {
        let label = UILabel()
        label.font = .style(.date)
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private let newsContent: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .style(.content)
        
        return label
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let contentScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        
        return scroll
    }()
    
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20.0
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 15.0, bottom: 30.0, right: 15.0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        image.kf.setImage(with: model.imageLink, placeholder: UIImage(named: "Placeholder"))
        newsTitle.text = model.title
        newsDate.text = model.date.localizedString()
        newsContent.text = model.content
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("button.share", comment: ""),
            style: .plain,
            target: self,
            action: #selector(shareTapped)
        )
    }
    
    @objc func shareTapped() {
        guard let newsLink = model.newsLink else { return }
        let activityVC = UIActivityViewController(
            activityItems: [model.title, newsLink],
            applicationActivities: nil
        )
        
        activityVC.excludedActivityTypes = [
            .message,
            .airDrop,
            .addToReadingList,
            .postToFacebook
        ]
        
        DispatchQueue.main.async {
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    override func setupSubviews() {
        view.addSubview(contentScrollView)
        
        contentScrollView.addSubview(contentStackView)
        contentScrollView.addSubview(image)
        
        contentStackView.addArrangedSubview(newsTitle)
        contentStackView.addArrangedSubview(newsDate)
        contentStackView.addArrangedSubview(separator)
        contentStackView.addArrangedSubview(newsContent)
    }
    
    override func setupLayout() {
        contentScrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        separator.snp.makeConstraints { $0.height.equalTo(2.0) }
        contentStackView.setCustomSpacing(10.0, after: newsTitle)
        
        contentStackView.snp.makeConstraints { make in
            make.bottom.left.right.width.equalToSuperview()

            if model.imageLink == nil {
                make.top.equalToSuperview().inset(10.0)
            } else {
                make.top.equalTo(image.snp.bottom).inset(-10.0)
            }
        }
        
        image.snp.makeConstraints { make in
            make.height.equalTo(200.0)
            make.left.right.top.equalToSuperview()
        }
    }
}
