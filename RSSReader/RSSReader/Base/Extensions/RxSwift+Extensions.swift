//
//  RxSwift+Extensions.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import Foundation
import RxSwift

extension ObservableType {
    func voidValues() -> Observable<Void> {
        return map { _ in () }
    }
    
    func onMain() -> RxSwift.Observable<Self.Element> {
        return observe(on: MainScheduler.asyncInstance)
    }
}
