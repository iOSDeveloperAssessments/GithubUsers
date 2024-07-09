//
//  GithubEnpoint.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

protocol Paginable {
  var perPage: Int? { get set }
  var since: Int? { get set }
}

protocol GithubEnpoint: Endpoint, URLRequestable {
}

extension GithubEnpoint {
  var scheme: String { "https" }
  var host: String { "api.github.com" }
  var baseURLString: String { "" }
  var queryParameters: [String : String]? { .none }
  var method: Method { .get }
  var path: String { "" }
  var perPage: Int { 20 }
  var page: Int { .zero }
}

extension GithubEnpoint {
  var urlRequest: URLRequest? {

    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.path = baseURLString + path
    components.queryItems = queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

    guard let url = components.url else { return .none }

    var request = URLRequest(url: url)
    request.httpMethod = method.string

    return request
  }
}
