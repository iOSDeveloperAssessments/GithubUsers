//
//  RepositoryAdapterTests.swift
//  GithubUsersTests
//
//  Created by David Alarcon on 10/7/24.
//

import XCTest
@testable import GithubUsers

final class RepositoryAdapterTests: XCTestCase {
  func testRepositoryAdapter() {
    /// Given
    let response = RepositoryResponse(
      id: Constants.id,
      name: Constants.name,
      language: Constants.language
    )
    let sut = RepositoryAdapter(response: response)

    /// When
    let user = sut.adapt()

    /// Then
    XCTAssertEqual(user.id, Constants.id)
    XCTAssertEqual(user.name, Constants.name)
    XCTAssertEqual(user.language, Constants.language)
  }

  func testRepositoryAdapterWithNilName() {
    /// Given
    let response = RepositoryResponse(
      id: Constants.id,
      language: Constants.language
    )
    let sut = RepositoryAdapter(response: response)

    /// When
    let user = sut.adapt()

    /// Then
    XCTAssertEqual(user.id, Constants.id)
    XCTAssertNil(user.name)
    XCTAssertEqual(user.language, Constants.language)
  }

  func testRepositoryAdapterWithNilLanguage() {
    /// Given
    let response = RepositoryResponse(
      id: Constants.id,
      name: Constants.name
    )
    let sut = RepositoryAdapter(response: response)

    /// When
    let user = sut.adapt()

    /// Then
    XCTAssertEqual(user.id, Constants.id)
    XCTAssertEqual(user.name, Constants.name)
    XCTAssertNil(user.language)
  }
}

extension RepositoryAdapterTests {
  enum Constants {
    static let id = 1
    static let name = "Name"
    static let language = "Swift"
  }
}
