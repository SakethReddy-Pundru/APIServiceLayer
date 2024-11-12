//
//  HTTPMethod.swift
//  APIServiceLayer
//
//  Created by Saketh Reddy on 12/11/24.
//

import Foundation

// MARK: - HTTPMethod Struct

/// A struct representing HTTP methods, conforming to
/// `RawRepresentable (It can be initialized with raw values (like strings))`,
/// `Equatable(can check if two instances are equal)`, and
/// `Hashable(can use it in collections that require hashing, like sets or dictionaries)`.
///
public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    
    // MARK: - HTTP Method Constants
    
    public static let connect = HTTPMethod(rawValue: "CONNECT")
    public static let delete = HTTPMethod(rawValue: "DELETE")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    
    public let rawValue: String
    
    // MARK: - Initializer
    
    /// Initializes an `HTTPMethod` with the given raw string value.
    /// - Parameter rawValue: The raw string value of the HTTP method.
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
