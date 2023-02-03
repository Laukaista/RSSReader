//
//  NetworkError.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case getDataError
    case parseError
}
