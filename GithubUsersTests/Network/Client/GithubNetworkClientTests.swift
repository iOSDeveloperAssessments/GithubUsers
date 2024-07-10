//
//  GithubNetworkClientTests.swift
//  GithubUsersTests
//
//  Created by David Alarcon on 10/7/24.
//

import XCTest
@testable import GithubUsers

final class GithubNetworkClientTests: XCTestCase {

  func testGithubNetworkClientUsers() async throws {
    /// Given
    let networkService = MockNetworkService()
    let response = try DummyLoader<[GithubUserResponse]>.load(name: "GithubUsers")
    networkService.requestResult = response
    let expectedResult = response.compactMap { GithubUserAdapter(response: $0).adapt() }
    let sut = GithubNetworkClient(networkService: networkService)

    /// When
    let result = try await sut.users()

    /// Then
    XCTAssertEqual(result, expectedResult)
  }

  func testGithubNetworkClientUser() async throws {
    /// Given
    let networkService = MockNetworkService()
    let response = try DummyLoader<GithubUserResponse>.load(name: "GithubUser")
    let repositoriesResponse = try DummyLoader<[RepositoryResponse]>.load(name: "Repositories")
    let followersResponse = try DummyLoader<[GithubUserResponse]>.load(name: "GithubUsers")
    networkService.requestResult = response
    networkService.reposRequestResult = repositoriesResponse
    networkService.followersRequestResult = followersResponse
    let sut = GithubNetworkClient(networkService: networkService)

    /// When
    let expectedResult = GithubUserAdapter(response: response).adapt()
    let expectedRepositoriesResult = repositoriesResponse.compactMap { RepositoryAdapter(response: $0).adapt() }
    let expectedFollowersResult = followersResponse.compactMap { GithubUserAdapter(response: $0).adapt() }
    let result = try await sut.user(id: 1)

    /// Then
    XCTAssertEqual(result, expectedResult)
    XCTAssertEqual(result.repositories, expectedRepositoriesResult)
    XCTAssertEqual(result.followers, expectedFollowersResult)
  }
}

extension GithubUser: Equatable {
  public static func == (lhs: GithubUsers.GithubUser, rhs: GithubUsers.GithubUser) -> Bool {
    lhs.id == rhs.id
  }
}

extension Repository: Equatable {
  public static func == (lhs: Repository, rhs: Repository) -> Bool {
    lhs.id == rhs.id
  }
}
