//
//  RepositoriesEndpoint.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

struct RepositoriesEndpoint: GithubEnpoint {
  var urlString: String

  var urlRequest: URLRequest? {
    guard let url = URL(string: urlString) else { return .none }

    var request = URLRequest(url: url)
    request.httpMethod = method.string

    return request
  }
}
