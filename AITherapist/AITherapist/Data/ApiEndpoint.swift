//
//  ApiEndpoint.swift
//  AITherapist
//
//  Created by Shirin-Yan on 11.08.2024.
//

import Foundation
import Alamofire

protocol Endpoint {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var encoder: ParameterEncoder { get }
    var header: HTTPHeaders { get }
    var body: [String: String]? { get }
}

let BASE_URL = ""

enum Endpoints {
    
}
