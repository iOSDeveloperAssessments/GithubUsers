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
        List {
          Section {
            HStack {
              AsyncImage(url: user.avatarURL) { phase in
                switch phase {
                case .empty: ProgressView()
                case .success(let image):
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                case .failure(_):
                  Image(systemName: "person.crop.circle.badge.exclamationmark")
                @unknown default:
                  Image(systemName: "person.crop.circle.badge.exclamationmark")
                }
              }
              .frame(width: 100, height: 100)
              .clipShape(.rect(cornerRadii: .init(topLeading: 10, bottomLeading: 10, bottomTrailing: 10, topTrailing: 10)))
              Spacer()
              VStack(alignment: .trailing) {
                Text(user.name ?? "")
                  .font(.title3)
                Text(user.username)
                  .font(.headline)
              }
            }
          }
          if let repositories = user.repositories {
            Section("Repositories") {
              ForEach(repositories) { repository in
                HStack(spacing: 5) {
                  if let name = repository.name {
                    Text(name)
                      .lineLimit(1)
                  }
                  Spacer()
                  if let language = repository.language {
                    Text(language)
                      .font(.subheadline)
                      .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                      .padding(5)
                      .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                      .overlay(
                        RoundedRectangle(cornerRadius: 5)
                          .stroke(Color.black, lineWidth: 1)
                      )
                  }
                }
              }
            }
          }
          Section("Followers") {
            ForEach(user.followers ?? []) { follower in
              UserRowView(user: follower)
            }
          }
        }
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
