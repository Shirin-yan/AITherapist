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
    var body: OpenAiBody? { get }
}

let BASE_URL = ""

enum Endpoints: Endpoint {
    case openAiCompletion([OpenAiMessage])
    
    var method: Alamofire.HTTPMethod {
        return .post
    }
    
    var path: String {
        return "https://api.openai.com/v1/chat/completions"
    }
    
    var encoder: any Alamofire.ParameterEncoder {
        return JSONParameterEncoder.default
    }
    
    var header: Alamofire.HTTPHeaders {
        return ["Content-Type": "application/json",
                "Authorization": "Bearer \(OPENAI_API_KEY)"]
    }
    
    var body: OpenAiBody? {
        switch self {
        case .openAiCompletion(let array):
            var m = [INITIAL_MESSAGE]+array
            return OpenAiBody(messages: m)
        }
    }
}
