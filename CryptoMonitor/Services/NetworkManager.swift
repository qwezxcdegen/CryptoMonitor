//
//  NetworkManager.swift
//  CryptoMonitor
//
//  Created by Степан Фоминцев on 09.05.2023.
//

import Foundation

enum NetworkError: Error {
    case brokenURL
    case dataError
    case decodeError
    case error
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.dataError))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.brokenURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [unowned self] data, _, error in
            guard let data else {
                completion(.failure(.dataError))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            if let parsedData = parseJSON(type.self, fromData: data) {
                DispatchQueue.main.async {
                    completion(.success(parsedDataç))
                }
            } else {
                completion(.failure(.decodeError))
            }
            
        }.resume()
    }
    
    
    private func parseJSON<T: Decodable>(_ type: T.Type, fromData data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(type.self, from: data)
            return decodedData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

