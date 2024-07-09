//
//  APIManager.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 18/06/24.
//

import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler = (Result <[Product], DataError>) -> Void
// singleton design pattern
final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
            200...299 ~= response.statusCode else  {
                completion(.failure(.invalidResponse))
                return
            }
            //  json decoder change data to model(Array)
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
}
