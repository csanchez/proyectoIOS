//
//  URLSessionExtension.swift
//  AppIIS
//
//  Created by tecnologias on 19/10/22.
//

import Foundation

/*

typealias Handler<T> = (Result<T, Error>) -> Void

extension URLSession {
    func dataTask(with url: URLRequest, completionHandler: @escaping Handler<Data>) {
        dataTask(with: url) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(data ?? Data()))
            }
        }
    }
}

extension Result where Success == Data {
    func decode<T: Decodable>(with decoder: JSONDecoder = .init()) -> Result<T, Error> {
        do {
            let data = try get()
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }
}
*/
