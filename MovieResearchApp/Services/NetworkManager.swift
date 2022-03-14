//
//  NetworkManager.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 8.03.2022.
//

import Foundation
import Moya

class NetworkManager {
    class func provider() -> MoyaProvider<API> {
        let requestClosure = {(endpoint: Endpoint, done: @escaping MoyaProvider<API>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 15
                done(.success(request))
            } catch {
                print(error.localizedDescription)
            }
        }
        return MoyaProvider<API>(requestClosure: requestClosure)
    }
}
