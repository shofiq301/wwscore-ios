//
//  json+helper.swift
//  API-Football
//
//  Created by Shahanul Haque on 2/21/25.
//

import Foundation
// Helper type to handle arbitrary JSON values while maintaining Sendable conformance
@frozen public enum AnyJSON: Sendable, Codable {
    case string(String)
    case number(Double)
    case bool(Bool)
    case array([AnyJSON])
    case object([String: AnyJSON])
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let number = try? container.decode(Double.self) {
            self = .number(number)
        } else if let array = try? container.decode([AnyJSON].self) {
            self = .array(array)
        } else if let object = try? container.decode([String: AnyJSON].self) {
            self = .object(object)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "AnyJSON value cannot be decoded")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try container.encode(string)
        case .number(let number):
            try container.encode(number)
        case .bool(let bool):
            try container.encode(bool)
        case .array(let array):
            try container.encode(array)
        case .object(let object):
            try container.encode(object)
        case .null:
            try container.encodeNil()
        }
    }
}
