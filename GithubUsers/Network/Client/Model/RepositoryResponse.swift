//
//  RepositoryResponse.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

struct RepositoryResponse: Decodable {
  var id: Int
  var name: String?
  var language: String?
}
