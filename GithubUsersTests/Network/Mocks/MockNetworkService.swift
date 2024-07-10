//
//  MockNetworkService.swift
//  OpenWeatherMapTests
//
//  Created by David Alarcon on 18/4/24.
//

import Foundation
@testable import GithubUsers

class MockNetworkService: NetworkServiceProtocol {

  var requestResult: Decodable?
  var reposRequestResult: Decodable?
  var followersRequestResult: Decodable?

  func request<T: Decodable>(from requestConvertible: URLRequestable) async throws -> T {

    switch requestConvertible {
    case is RepositoriesEndpoint:
      guard let result = reposRequestResult as? T else { throw NetworkError.invalidResponse(.none) }

      return result
    case is FollowersEndpoint:
      guard let result = followersRequestResult as? T else { throw NetworkError.invalidResponse(.none) }

      return result
    default:
      guard let result = requestResult as? T else { throw NetworkError.invalidResponse(.none) }

      return result
    }
  }
}
