//
//  RepositoryRowView.swift
//  GithubUsers
//
//  Created by David Alarcon on 10/7/24.
//

import SwiftUI

struct RepositoryRowView: View {
  var repository: Repository

  var body: some View {
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

#Preview {
  RepositoryRowView(repository: .init(id: 1, name: "repository.github.com", language: "Swift"))
}
