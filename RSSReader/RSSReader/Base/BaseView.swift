//
//  BaseView.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import UIKit
import SnapKit
import RxSwift

open class BaseView: UIView {
    public let disposeBag = DisposeBag()

    public init() {
        super.init(frame: .zero)

        setupSubviews()
        setupLayout()
        setupHandlers()
    }

    open func setupSubviews() {

    }

    open func setupLayout() {

    }

    open func setupHandlers() {

    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

