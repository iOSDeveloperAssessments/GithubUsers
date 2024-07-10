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
  /// WARNING: Should not be here. Just for the assessment. Valid for 30 days.
  var headers: [String : String]? { ["Authorization": "Bearer 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"] }
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

    if let headers = headers {
      for header in headers {
        request.addValue(header.value, forHTTPHeaderField: header.key)
      }
    }

    return request
  }
}
