//
//  DocumentsService.swift
//  Navigation
//
//  Created by Владимир Камнев on 21.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

enum DocumentsErrors: String, Error {
    case badURL       = "Неправильный путь"
    case badGet       = "Ошибка в получении данных"
    case badImageData = "Не удалось преобразовать картинку в Data"
    case badSave      = "Не удалось сохранить Data"
}

enum DocumentsService {
    private static var getURL: URL? {
        /// В директории documents отстутствуют файлы, поменял на library
        return try? FileManager.default.url(for: .libraryDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
    }
    
    static func getNames(callback: @escaping (Result<[String], DocumentsErrors>) -> Void) {
        guard let libURL = getURL,
              let contents = try? FileManager.default.contentsOfDirectory(atPath: libURL.path)
        else {
            callback(.failure(.badGet))
            return
        }
        callback(.success(contents))
    }
    
    static func save(_ image: UIImage) -> DocumentsErrors? {
        guard let libURL = getURL else {
            return .badURL
        }
        
        let imageURL = libURL.appendingPathComponent(image.description)
        
        guard let dataImage = image.jpegData(compressionQuality: 0.5) else {
            return .badImageData
        }
        
        guard FileManager.default.createFile(atPath: imageURL.path, contents: dataImage, attributes: nil) else {
            return .badSave
        }
        
        return .none
    }
    
    static func deleteFile(name: String) -> DocumentsErrors? {
        guard let libURL = getURL else {
            return .badURL
        }
        
        let fileURL = libURL.appendingPathComponent(name)
        
        do {
            try FileManager.default.removeItem(atPath: fileURL.path)
        } catch {
            return .badURL
        }
        
        return nil
    }
}
