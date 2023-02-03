//
//  StorageServiceProtocol.swift
//  RSSReader
//
//  Created by Dmitriy Veremei on 3.02.23.
//

import Foundation

protocol StorageServiceProtocol {
    func createEntity(from models: [NewsModel], completion: @escaping (Bool) -> Void)
    func readEntities(completion: @escaping ([News]) -> Void)
    func updateEntity(from model: NewsModel, completion: @escaping (Bool) -> Void)
    func deleteEntity(with title: String, completion: @escaping (Bool) -> Void)
}
