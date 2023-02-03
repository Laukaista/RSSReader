//
//  NewsListCell.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import UIKit
import Kingfisher

final class NewsListCell: CollectionCell<NewsModel> {
    private var shadowLayer: CAShapeLayer?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .style(.title)
        label.numberOfLines = 2
        label.textAlignment = .left
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .style(.date)
        label.numberOfLines = 1
        label.textAlignment = .left
        
        return label
    }()
    
    private let viewedMark: UILabel = {
        let label = UILabel()
        label.font = .style(.viewed)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "Просмотрено"
        
        return label
    }()
    
    private let newsContent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CardBackground")
        view.layer.cornerRadius = 16.0

        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16.0
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let cardContent: UIView = UIView()
    
    override func setupSubviews() {
        newsContent.addSubview(titleLabel)
        newsContent.addSubview(dateLabel)
        newsContent.addSubview(viewedMark)
        
        cardContent.addSubview(imageView)
        cardContent.addSubview(newsContent)
        
        addSubview(cardContent)
    }
    
    override func setupLayout() {
        cardContent.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 40.0)
            make.height.equalTo(50.0)
        }
        
        newsContent.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.top).inset(-10.0)
            make.width.equalTo(UIScreen.main.bounds.width - 40.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10.0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(10.0)
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).inset(-5.0)
        }
        
        viewedMark.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(10.0)
            make.top.equalTo(titleLabel.snp.bottom).inset(-5.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 40.0)
            make.height.equalTo(200.0)
            make.edges.equalToSuperview()
        }
    }
    
    override func updateModel(_ model: NewsModel) {
        super.updateModel(model)
        
        titleLabel.text = model.title
        dateLabel.text = model.date.localizedString()
        
        if let imageLink = model.imageLink {
            imageView.kf.setImage(with: imageLink)
            
            cardContent.snp.remakeConstraints { make in
                make.height.equalTo(imageView.snp.height)
                make.edges.equalToSuperview()
                make.width.equalTo(UIScreen.main.bounds.width - 40.0)
            }
        } else {
            cardContent.snp.remakeConstraints { make in
                make.height.equalTo(newsContent.snp.height)
                make.width.equalTo(UIScreen.main.bounds.width - 40.0)
                make.edges.equalToSuperview()
            }
        }
        
        viewedMark.isHidden = !model.viewed
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        dateLabel.text = ""
        imageView.image = nil
        viewedMark.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
          
            shadowLayer!.path = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0).cgPath

            shadowLayer!.shadowColor = UIColor(named: "Shadow")?.cgColor
            shadowLayer!.shadowPath = shadowLayer!.path
            shadowLayer!.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer!.shadowOpacity = 0.2
            shadowLayer!.shadowRadius = 3

            layer.insertSublayer(shadowLayer!, at: 0)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        shadowLayer?.shadowColor = UIColor(named: "Shadow")?.cgColor
    }
}
