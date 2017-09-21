//
//  NetworkProvider.swift
//  IMDTest
//
//  Created by Agil Febrianistian on 9/16/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup

struct AuthPlugin: PluginType {
    let token: String
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue(token, forHTTPHeaderField: "api-key")
        return request
    }
}

let apiProvider = MoyaProvider<ApiConstant>(plugins: [AuthPlugin(token:"uWMhqwnJJvul39UWGOGh9VS6arST3bFK")])

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum ApiConstant {
    case getPSIData(stringDate:String)
}

extension ApiConstant: TargetType {
    public var baseURL: URL { return URL(string: "https://api.data.gov.sg/v1/")! }
    public var path: String {
        switch self {
        case .getPSIData:
            return "environment/psi"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getPSIData:
            return .get
         }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getPSIData(let stringDate):
            return ["date": stringDate]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
    
    public var validate: Bool {
        switch self {
        default:
            return false
        }
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return "".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
