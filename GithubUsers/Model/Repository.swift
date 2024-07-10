//
//  Repository.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation
import SwiftData

@Model
final class Repository: Identifiable {
  @Attribute(.unique) var id: Int
  var name: String?
  var language: String?
  
  init(id: Int, name: String? = nil, language: String? = nil) {
    self.id = id
    self.name = name
    self.language = language
  }
}
