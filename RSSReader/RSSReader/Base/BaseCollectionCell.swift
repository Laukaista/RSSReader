//
//  BaseCollectionCell.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import UIKit
import SnapKit
import RxSwift

class BaseCollectionCell: UICollectionViewCell {
    private(set) var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        backgroundColor = .clear

        setupSubviews()
        setupLayout()
        setupHandlers()
    }

    func setupSubviews() {

    }

    func setupLayout() {

    }

    func setupHandlers() {

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()

        self.setupHandlers()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionCell<T>: BaseCollectionCell where T: Model {
    public var model: T?
    
    func updateModel(_ model: T) {
        self.model = model
    }
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

