//
//  LentaRuRssService.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation

final class RSSService: NSObject, RSSServiceProtocol {
    typealias Model = NewsItem
    
    var parser: XMLParser?
    var currentElement = ""
    var item: NewsItem?
    var result: [NewsItem] = []
    var parserCompletionHandler: ((Result<[NewsItem], NetworkError>) -> Void)?
    
    func parseFeed(
        link: String,
        completionHandler: @escaping (Result<[NewsItem], NetworkError>) -> Void
    ) {
        parserCompletionHandler = completionHandler
        getData(urlString: link) { result in
            switch result {
            case let .success(data):
                self.parse(data: data)
            case let .failure(error):
                self.parserCompletionHandler?(.failure(error))
            }
        }
    }
}

extension RSSService: XMLParserDelegate {
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        currentElement = elementName

        if currentElement == "item"{
            item = NewsItem()
        }
        if currentElement == "enclosure"{
            guard let link = attributeDict["url"] else {
                return
            }
            item?.imageLink = link
        }
    }

    func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        let test = string.trimmingCharacters(in: .whitespaces)

        if test != "\n" {
            switch currentElement {
            case "author" :
                item?.author = string
            case "title" :
                item?.title = string
            case "link" :
                item?.link = string
            case "description":
                item?.descr = string
            case "pubDate":
                item?.pubDate = string
            case "category":
                item?.category = string
            default:
                break
            }
        }
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        if elementName == "item",
        let item {
            result.append(item)
            self.item = nil
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(.success(result))
    }

    func parser(
        _ parser: XMLParser,
        parseErrorOccurred parseError: Error
    ) {
        parserCompletionHandler?(.failure(.parseError))
    }
}

