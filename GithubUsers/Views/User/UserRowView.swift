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
    HStack(spacing: 20) {
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
      Text(String(user.id))
        .font(.subheadline)
      Text(user.username)
          .font(.title2)
          .lineLimit(1)
      Spacer()
    }
  }
}

#Preview {
  UserRowView(user: .init(id: .zero, username: "Preview"))
}
