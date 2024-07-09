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
  @State private var since = Int.zero
  @State private var searchText = ""

  private var filteredUsers: [GithubUser] {
    searchText.isEmpty ? users : users.filter {
      $0.username.lowercased().contains(searchText.lowercased())
    }
  }

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
            ForEach(filteredUsers) { user in
              UserRowView(user: user)
                .background {
                  NavigationLink(value: user.id) {}
                    .opacity(.zero)
                }
                .onAppear {
                  if let lastId = users.last?.id,
                     user.id ==  lastId {
                    Task { await fetchNextUsers() }
                  }
                }
            }
          }
          .navigationTitle("Github Users")
          .navigationDestination(for: Int.self) { id in
            UserView(id: id)
              .environment(api)
          }
          .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Username")
        }
        Text("Loaded Pages: \(currentPage)")
          .font(.subheadline)
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
      let nextUsers = try await api.users(at: since)
      users.append(contentsOf: nextUsers)
      currentPage += 1
      since = nextUsers.last?.id ?? .zero
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
