//
//  UsersEndpoint.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

struct UsersEndpoint: GithubEnpoint, Paginable {
  var since: Int?
  var perPage: Int? = 20

  var path: String { "/users" }
  var queryParameters: [String : String]? {
    guard let perPage = perPage, let since = since else { return .none }

    return ["per_page": String(perPage), "since": String(since)]
  }
}
