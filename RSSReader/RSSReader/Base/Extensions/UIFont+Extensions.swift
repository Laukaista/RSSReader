//
//  UIFont+Extensions.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 2.02.23.
//

import Foundation
import UIKit

enum FontWeight {
    case bold
    case semibold
    case medium
    case regular
}

enum FontStyle {
    case title
    case date
    case cardTitle
    case cardDate
    case viewed
    case content
    
    var defaultSize: CGFloat {
        switch self {
        case .title:
            return 24
        case .date:
            return 20
        case .cardTitle:
            return 17
        case .cardDate:
            return 14
        case .viewed:
            return 12
        case .content:
            return 20
        }
    }

    var fontWeight: FontWeight {
        switch self {
        case .cardTitle, .title:
            return .bold
        case .cardDate, .viewed, .date:
            return .medium
        case .content:
            return .regular
        }
    }
}

extension UIFont {
    static func style(_ style: FontStyle, _ forSmall: CGFloat = 0) -> UIFont? {
        let isSmallPhone = UIScreen.main.bounds.size == CGSize(width: 320, height: 568)
        let defaultSize: CGFloat = style.defaultSize
        let size: CGFloat
                
        if isSmallPhone {
            size = forSmall > 0 ? forSmall : defaultSize
        } else {
            size = defaultSize
        }
                
        switch style.fontWeight {
        case .bold:
            return self.systemFont(ofSize: size, weight: .bold)
        case .semibold:
            return self.systemFont(ofSize: size, weight: .semibold)
        case .medium:
            return self.systemFont(ofSize: size, weight: .medium)
        case .regular:
            return self.systemFont(ofSize: size, weight: .regular)
        }
    }
}

