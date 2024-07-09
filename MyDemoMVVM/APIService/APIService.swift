//
//  APIService.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 02/06/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        // Dummy URL for the example
        guard let url = URL(string: "https://example.com/api/login") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                // Assuming the response JSON has a "user" object
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
