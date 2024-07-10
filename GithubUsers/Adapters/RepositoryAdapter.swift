//
//  RepositoryAdapter.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

class RepositoryAdapter: Adapter {
  private let adaptee: RepositoryResponse

  init(response: RepositoryResponse) {
    self.adaptee = response
  }

  func adapt() -> Repository {
    .init(id: adaptee.id, name: adaptee.name, language: adaptee.language)
  }
}
