//
//  BaseView.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import UIKit
import SnapKit
import RxSwift

class BaseView: UIView {
    let disposeBag = DisposeBag()

    init() {
        super.init(frame: .zero)

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

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

