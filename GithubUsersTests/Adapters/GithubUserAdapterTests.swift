//
//  GithubUserAdapterTests.swift
//  GithubUsersTests
//
//  Created by David Alarcon on 10/7/24.
//

import XCTest
@testable import GithubUsers

final class GithubUserAdapterTests: XCTestCase {

  func testGithubUserAdapter() {
    /// Given
    let response = GithubUserResponse(
      id: Constants.id,
      login: Constants.username,
      avatar_url: Constants.avatarURL,
      name: Constants.name
    )
    let sut = GithubUserAdapter(response: response)

    /// When
    let user = sut.adapt()

    /// Then
    XCTAssertEqual(user.id, Constants.id)
    XCTAssertEqual(user.username, Constants.username)
    XCTAssertEqual(user.avatarURL, URL(string: Constants.avatarURL))
    XCTAssertEqual(user.name, Constants.name)
  }

  func testGithubUserAdapterWithNilName() {
    /// Given
    let response = GithubUserResponse(
      id: Constants.id,
      login: Constants.username,
      avatar_url: Constants.avatarURL
    )
    let sut = GithubUserAdapter(response: response)

    /// When
    let user = sut.adapt()

    /// Then
    XCTAssertEqual(user.id, Constants.id)
    XCTAssertEqual(user.username, Constants.username)
    XCTAssertEqual(user.avatarURL, URL(string: Constants.avatarURL))
    XCTAssertNil(user.name)
  }

  func testGithubUserAdapterWithInvalidAvatarURL() {
    /// Given
    let response = GithubUserResponse(
      id: Constants.id,
      login: Constants.username,
      avatar_url: "",
      name: Constants.name
    )
    let sut = GithubUserAdapter(response: response)

    /// When
    let user = sut.adapt()

    /// Then
    XCTAssertEqual(user.id, Constants.id)
    XCTAssertEqual(user.username, Constants.username)
    XCTAssertNil(user.avatarURL)
    XCTAssertEqual(user.name, Constants.name)
  }
}

extension GithubUserAdapterTests {
  enum Constants {
    static let id = 1
    static let username = "Username"
    static let avatarURL = "https://this/is/a/test/avatar.png"
    static let name = "Name"
  }
}
