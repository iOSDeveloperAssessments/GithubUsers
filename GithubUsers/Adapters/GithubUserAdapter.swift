//
//  GithubUserAdapter.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

protocol Adapter {
  associatedtype Target

  func adapt() -> Target
}

class GithubUserAdapter: Adapter {
  private let adaptee: GithubUserResponse

  init(response: GithubUserResponse) {
    self.adaptee = response
  }

  func adapt() -> GithubUser {
    .init(username: adaptee.login, avatarURL: URL(string: adaptee.avatar_url))
  }
}
