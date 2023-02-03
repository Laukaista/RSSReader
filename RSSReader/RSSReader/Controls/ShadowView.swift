//
//  ShadowView.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import UIKit

class ShadowView: BaseView {
    var shadowColor: UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.25) {
        didSet { self.layer.shadowColor = shadowColor.cgColor }
    }
    
    var shadowRadius: CGFloat = 20 {
        didSet { self.layer.shadowRadius = shadowRadius }
    }
    var shadowOffset: CGSize = .zero {
        didSet { self.layer.shadowOffset = shadowOffset }
    }
    var shadowPathCorner: CGFloat = 0
    var shadowOpacity: Float = 1 {
        didSet { self.layer.shadowOpacity = shadowOpacity }
    }
    
    override init() {
        super.init()
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.bounds = self.bounds
        self.layer.shadowPath = UIBezierPath(
            roundedRect: self.bounds,
            cornerRadius: shadowPathCorner
        ).cgPath
        self.layer.position = self.center
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.layer.shadowColor = shadowColor.cgColor
    }
}

