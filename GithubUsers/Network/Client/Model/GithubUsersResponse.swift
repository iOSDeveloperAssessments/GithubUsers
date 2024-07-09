//
//  GithubUsersResponse.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

struct GithubUsersResponse: Decodable {
  var users: [GithubUserResponse]
}
