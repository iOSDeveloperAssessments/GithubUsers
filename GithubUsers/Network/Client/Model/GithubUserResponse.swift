//
//  GithubUserResponse.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

struct GithubUserResponse: Decodable {
  var id: Int
  var login: String
  var avatar_url: String

  var name: String?
  var repos_url: String?
  var followers_url: String?
}
