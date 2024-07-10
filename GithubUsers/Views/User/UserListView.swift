//
//  UserListView.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI
import SwiftData

struct UserListView: View {
  @Environment(GithubNetworkClient.self) private var api
  @Environment(\.modelContext) private var modelContext

  @Query(sort: \GithubUser.id, order: .forward) private var users: [GithubUser] = []
  @State private var viewState: ViewState = .loading
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
      }
    }
    .task {
      if users.isEmpty { await fetchNextUsers() }
      else {
        viewState = .users
        since = users.last?.id ?? .zero
      }
    }
  }
}

extension UserListView {
  private func fetchNextUsers() async {
    do {
      let nextUsers = try await api.users(at: since)
      for user in nextUsers {
        modelContext.insert(user)
      }
      try modelContext.save()
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
      .modelContainer(for: GithubUser.self, inMemory: true)
  }
}
