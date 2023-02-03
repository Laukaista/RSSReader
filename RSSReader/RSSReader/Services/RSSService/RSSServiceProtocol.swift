//
//  RSSServiceProtocol.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation

public protocol RSSServiceProtocol: XMLParserDelegate {
    associatedtype Model
    
    func parseFeed(link: String, completionHandler: @escaping (Result<[Model], NetworkError>) -> Void)
    
    var parser: XMLParser? { get set }
    var currentElement: String { get }
    var item: Model? { get }
    var result: [Model] { get }
    var parserCompletionHandler: ((Result<[Model], NetworkError>) -> Void)? { get }
}

public extension RSSServiceProtocol {
    func getData(urlString: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 30.0
           
        let urlSession = URLSession(configuration: sessionConfig)
        let task = urlSession.dataTask(with: request) {[weak self] data, _, error in
            guard let _ = self,
                  let data = data else {
                if error != nil {
                    completion(.failure(.getDataError))
                }
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    func parse(data: Data) {
        let parser = XMLParser(data: data)
        self.parser = parser
        parser.delegate = self
        parser.parse()
    }
}
