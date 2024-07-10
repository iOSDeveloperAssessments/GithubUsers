//
//  DummyInvalidURLEndpoint.swift
//  OpenWeatherMapTests
//
//  Created by David Alarcon on 18/4/24.
//

import Foundation
@testable import GithubUsers

struct DummyInvalidURLEndpoint: GithubEnpoint {
  var host: String { "test.com" }
  var baseURLString: String { "this/is/a" } // No / at the beginning
  var path: String { "/test" }
}
