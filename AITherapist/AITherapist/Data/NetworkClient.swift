//
//  NetworkClient.swift
//  AITherapist
//
//  Created by Shirin-Yan on 11.08.2024.
//

import Foundation
import Alamofire

class Network {
    class func perform<T: Decodable>(endpoint: Endpoint, completionHandler: @escaping (Result<T, AFError>) -> Void) {
        AF.request(endpoint.path,
                   method: endpoint.method,
                   parameters: endpoint.body,
                   encoder: endpoint.encoder,
                   headers: endpoint.header)
            .validate()
            .responseDecodable(of: T.self) { resp in
                debugPrint(resp)
                switch resp.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}


