//
//  BaseViewController.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import Foundation
import UIKit
import RxSwift

protocol BaseViewControllerProtocol: UIViewController { }

class BaseViewController: UIViewController, BaseViewControllerProtocol, DisposableController {
    
    private(set) var disposeBag: DisposeBag! = DisposeBag()

    init(title: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.title = title
        
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

    deinit {
        print("[DEINIT]", self)
    }

    func dispose() {
        self.disposeBag = nil
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            self.dispose()
        }
    }
}

class ViewController<T>: UIViewController, BaseViewControllerProtocol, DisposableController where T: Model {
    private(set) var model: T
    
    private(set) var disposeBag: DisposeBag! = DisposeBag()

    init(title: String? = nil, model: T) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.title = title
        
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

    deinit {
        print("[DEINIT]", self)
    }

    func dispose() {
        self.disposeBag = nil
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            self.dispose()
        }
    }
}
