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
    case users
  }

  var body: some View {
    VStack {
      switch viewState {
      case .loading:
        Text("Loading users ...")
        ProgressView()
      case .error(let errorMessage):
        Text("Error: \(errorMessage)")
          .foregroundColor(.red)
      case .users:
        VStack {
          List {
            ForEach(users) { user in
              UserRowView(user: user)
            }
          }
          .navigationTitle("Github Users")
        }
      }
    }
    .task {
      if users.isEmpty { await fetchNextUsers() }
    }
  }
}

extension UserListView {
  private func fetchNextUsers() async {
    do {
      let nextUsers = try await api.users(at: currentPage)
      users.append(contentsOf: nextUsers)
      currentPage += 1
      viewState = .users
    } catch {
      viewState = .error(error.localizedDescription)
    }
  }
}

#Preview {
  NavigationStack {
    UserListView()
      .environment(GithubNetworkClient(networkService: NetworkService()))
  }
}
