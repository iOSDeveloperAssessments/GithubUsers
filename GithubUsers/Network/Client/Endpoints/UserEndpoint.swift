//
//  UserEndpoint.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import Foundation

struct UserEndpoint: GithubEnpoint {
  var id: Int

  var path: String { String("/user/\(id)") }
}
