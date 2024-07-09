//
//  UserView.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI

struct UserView: View {
  @Environment(GithubNetworkClient.self) private var api

  @State private var viewState: ViewState = .loading

  var id: Int

  enum ViewState {
    case loading
    case error(_ errorMessage: String)
    case user(user: GithubUser)
  }

  var body: some View {
    VStack {
      switch viewState {
      case .loading:
        Text("Loading user ...")
        ProgressView()
      case .error(let errorMessage):
        Text("Error: \(errorMessage)")
          .foregroundColor(.red)
      case .user(let user):
        Text(user.name ?? "")
      }
    }
    .task {
      await fetchUser()
    }
  }
}

extension UserView {
  private func fetchUser() async {
    do {
      let user = try await api.user(id: id)
      viewState = .user(user: user)
    } catch {
      viewState = .error(error.localizedDescription)
    }
  }
}

#Preview {
  UserView(id: 1)
    .environment(GithubNetworkClient(networkService: NetworkService()))
}
