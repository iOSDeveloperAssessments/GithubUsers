//
//  UserRowView.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI

struct UserRowView: View {
  var user: GithubUser

  var body: some View {
    HStack(spacing: 10) {
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
      .frame(width: 50, height: 50)
      .clipShape(.rect(cornerRadii: .init(topLeading: 10, bottomLeading: 10, bottomTrailing: 10, topTrailing: 10)))
      Text(user.username)
          .font(.title)
      Spacer()
    }
  }
}

#Preview {
  UserRowView(user: .init(username: "Preview"))
}
