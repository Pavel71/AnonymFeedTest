//
//  APIService.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//

import Foundation

enum APIConstants {
    static let feedItemsCount = 20
}

enum Endpoint {
    
    case first(_ count: Int)
    case after(_ cursor: String)
    case orderBy(_ filter: String)

    
    var baseURL:URL {URL(string: "https://k8s-stage.apianon.ru/posts/v1/posts")!}
    
    
    var absoluteURL: URL? {
        let queryURL = baseURL
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return nil
        }
        
        switch self {
        case .first(let count):
            urlComponents.queryItems = [URLQueryItem(name: "first", value: String(count))]
        case .after(let cursor):
            urlComponents.queryItems = [URLQueryItem(name: "after", value: cursor)]
        case .orderBy(let filter):
            urlComponents.queryItems = [URLQueryItem(name: "orderBy", value: filter)]
        }

        return urlComponents.url
    }
    
}


class APIService {
    
    func fetch(from endPoint: Endpoint, completion: @escaping (Result<Welcome,Error>) -> ()) {

        guard let url = endPoint.absoluteURL else { return }
        print("URl",url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            RunLoop.main.perform(inModes: [.common]) {
                do {
                    let object = try JSONDecoder().decode(Welcome.self, from: data)
                    completion(.success(object))
                } catch let error as NSError {
                    print(error.userInfo)
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}

    
    
