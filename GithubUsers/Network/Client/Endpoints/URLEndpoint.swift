//
//  URLEndpoint.swift
//  GithubUsers
//
//  Created by David Alarcon on 10/7/24.
//

import Foundation

protocol URLEndpoint: GithubEnpoint {
  var urlString: String { get set }
}

extension URLEndpoint {
  var urlRequest: URLRequest? {
    guard let url = URL(string: urlString) else { return .none }

    var request = URLRequest(url: url)
    request.httpMethod = method.string

    return request
  }
}
