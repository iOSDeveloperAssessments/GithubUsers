//
//  ContentView.swift
//  GithubUsers
//
//  Created by David Alarcon on 9/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  var body: some View {
    NavigationStack {
      UserListView()
        .environment(GithubNetworkClient(networkService: NetworkService()))
    }
  }
}

#Preview {
  ContentView()
}
