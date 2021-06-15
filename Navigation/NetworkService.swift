//
//  NetworkService.swift
//  Navigation
//
//  Created by Владимир Камнев on 14.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

enum NetworkErrors: Error {
    case badResponse
    case badJSON
    case badURL
    case badData
}

enum NetworkURLs: String {
    case post = "https://jsonplaceholder.typicode.com/todos/1"
    case planet = "https://swapi.dev/api/planets/1/"
}
    
struct NetworkService {
    static let urlSession = URLSession.shared
    
    typealias PostCallback = (Result<Post, Error>) -> Void
    typealias PlanetCallback = (Result<Planet, Error>) -> Void
    
    static func fetchPost(with urlString: String, callback: @escaping PostCallback) {
       
        let mainCallback: PostCallback = { result in
            DispatchQueue.main.async {
                callback(result)
                return
            }
        }
        guard let url = getUrl(from: urlString) else {
            callback(.failure(NetworkErrors.badURL))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let _error = error {
                mainCallback(.failure(_error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                mainCallback(.failure(NetworkErrors.badResponse))
                return
            }
            
            guard let _data = data else {
                mainCallback(.failure(NetworkErrors.badData))
                return
            }
            
            guard let post = Post.map(_data) else {
                mainCallback(.failure(NetworkErrors.badJSON))
                return
            }
            
            mainCallback(.success(post))
            
        }.resume()
    }
    
    static func fetchPlanet(with urlString: String, callback: @escaping PlanetCallback) {
       
        let mainCallback: PlanetCallback = { result in
            DispatchQueue.main.async {
                callback(result)
                return
            }
        }
        guard let url = getUrl(from: urlString) else {
            callback(.failure(NetworkErrors.badURL))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let _error = error {
                mainCallback(.failure(_error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                mainCallback(.failure(NetworkErrors.badResponse))
                return
            }
            
            guard let _data = data else {
                mainCallback(.failure(NetworkErrors.badData))
                return
            }
            
            guard let planet = try? JSONDecoder().decode(Planet.self, from: _data) else {
                mainCallback(.failure(NetworkErrors.badJSON))
                return
            }
            
            mainCallback(.success(planet))
            
        }.resume()
    }
    
    private static func getUrl(from urlString: String) -> URL? {
        return URL(string: urlString)
    }
}
