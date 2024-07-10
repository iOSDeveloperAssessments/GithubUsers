//
//  GithubUser.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation
import SwiftData

@Model
final class GithubUser: Identifiable {
  @Attribute(.unique) var id: Int
  var username: String
  var avatarURL: URL?

  var name: String?
  var followers: [GithubUser]?
  var repositories: [Repository]?
  
  init(id: Int, username: String, avatarURL: URL? = nil, name: String? = nil, followers: [GithubUser]? = nil, repositories: [Repository]? = nil) {
    self.id = id
    self.username = username
    self.avatarURL = avatarURL
    self.name = name
    self.followers = followers
    self.repositories = repositories
  }
}
