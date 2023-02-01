//
//  BaseViewController.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import Foundation
import UIKit
import RxSwift

public protocol BaseViewControllerProtocol: UIViewController { }

open class BaseViewController: UIViewController, BaseViewControllerProtocol, DisposableController {
    
    public private(set) var disposeBag: DisposeBag! = DisposeBag()

    public init(title: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.title = title
        
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

    deinit {
        print("[DEINIT]", self)
    }

    open func dispose() {
        self.disposeBag = nil
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            self.dispose()
        }
    }
}

