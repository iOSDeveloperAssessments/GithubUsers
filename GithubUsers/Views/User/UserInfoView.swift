//
//  UserInfoView.swift
//  GithubUsers
//
//  Created by David Alarcon on 10/7/24.
//

import SwiftUI

struct UserInfoView: View {
  var user: GithubUser

  var body: some View {
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
}

#Preview {
  UserInfoView(user: .init(
    id: 1,
    username: "Username",
    avatarURL: URL(string: "https://avatars.githubusercontent.com/u/1?v=4)"),
    name: "Preview Doe"
    ))
}
