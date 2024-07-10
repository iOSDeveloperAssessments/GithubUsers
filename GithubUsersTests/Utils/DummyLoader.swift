//
//  DummyLoader.swift
//  GithubUsersTests
//
//  Created by David Alarcon on 10/7/24.
//

import Foundation

protocol DummyLoadable {
  associatedtype T: Decodable
  
  static func load(name: String) throws -> T
}

class DummyLoader<T:Decodable>: DummyLoadable {
  static func load(name: String) throws -> T {
    guard let url = Bundle(for: self).url(forResource: name, withExtension: "json") else {
      throw NSError(domain: "DummyLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
    }
    
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return try decoder.decode(T.self, from: data)
  }
}
