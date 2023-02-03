//
//  DisposableController.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import RxSwift
import UIKit

protocol DisposableController {
    var disposeBag: DisposeBag! { get }
    func dispose()
}
