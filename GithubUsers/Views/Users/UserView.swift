//
//  UserView.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI

struct UserView: View {
  var username: String

  var body: some View {
    Text(username)
  }
}

#Preview {
  UserView(username: "Preview")
}
