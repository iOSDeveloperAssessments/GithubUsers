//
//  GithubUserResponse.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

struct GithubUserResponse: Decodable {
  var login: String
  var avatarUrl: String
}
