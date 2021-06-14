//
//  NetworkService.swift
//  Navigation
//
//  Created by Владимир Камнев on 13.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
import Foundation

enum NetworkError: Error {
    case badResponse
    case badData
}

struct NetworkService {
    static func fetchData(with configuration: AppConfiguration, callback: @escaping (Result<Data, Error>) -> ()) {
        guard let url = getURL(from: configuration) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                callback(.failure(error))
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                callback(.failure(NetworkError.badResponse))
                return
            }
            print("----------- http response -----------")
            print(httpResponse.statusCode)
            print(httpResponse.allHeaderFields)
            guard let data = data else {
                callback(.failure(NetworkError.badData))
                return
            }
            
            callback(.success(data))
        }.resume()
    }
    
    static func getURL(from configuration: AppConfiguration) -> URL? {
        switch configuration {
        case .peopleURL(let urlString):
            return URL(string: urlString)
        case .planetsURL(let urlString):
            return URL(string: urlString)
        case .starshipsURL(let urlString):
            return URL(string: urlString)
        }
    }
}
