//
//  UserListView.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI

struct UserListView: View {
  @Environment(GithubNetworkClient.self) private var api

  @State private var users: [GithubUser] = []
  @State private var viewState: ViewState = .loading
  @State private var currentPage = Int.zero

  enum ViewState {
    case loading
    case error(_ errorMessage: String)
    case users(_ data: [GithubUser])
  }

  var body: some View {
    VStack {
      switch viewState {
      case .loading:
        Text("Loading characters ...")
        ProgressView()
      case .error(let errorMessage):
        Text("Error: \(errorMessage)")
          .foregroundColor(.red)
      case .users(let users):
        Text("Users ...")
      }
    }
  }
}

#Preview {
  NavigationStack {
    UserListView()
      .environment(GithubNetworkClient(networkService: NetworkService()))
  }
}
