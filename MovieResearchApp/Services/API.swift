//
//  API.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 8.03.2022.
//

import Foundation
import Moya

enum API {
    case getMovie(_ movieID: String)
    case searchMovie(_ query: String, _ pageIndex: Int)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "\(Environment.baseUrl)")!
    }

    var path: String {
        switch self {
        case .searchMovie,
             .getMovie:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .searchMovie,
             .getMovie:
            return .get
        }
    }

    var headers: [String : String]? {
        switch self {
        case .searchMovie,
             .getMovie:
            return ["Content-Type": "application/json"]
        }
    }

    var task: Task {
        switch self {
        case .searchMovie(let query, let pageIndex):
            return .requestParameters(parameters: [
                "s" : query,
                "page": pageIndex,
                "apikey": Environment.apiKey
            ], encoding: URLEncoding.queryString)
        case .getMovie(let movieID):
            return .requestParameters(parameters: [
                "i":movieID,
                "apikey":Environment.apiKey
            ], encoding: URLEncoding.queryString)
        }
    }
}
