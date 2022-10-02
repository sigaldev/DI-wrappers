//
//  DependencyStore.swift
//  DI-wrappers
//
//  Created by Danil Sigal on 30.09.2022.
//

import Foundation

final class DependencyStore {
    static let shared = DependencyStore()

    private init() {}

    private var store: [Identifier: () -> Any] = [:]

    func resolve<T>() -> T {
        let id = identifier(for: T.self)

        guard let initializer = store[id] else {
            fatalError("Could not resolve for \(T.self) - did you forget to `DependencyStore.register(_:)` a concrete type?")
        }

        guard let value = initializer() as? T else {
            fatalError("Could not cast \(initializer()) to \(T.self)")
        }

        return value
    }

    public func register<T>(_ dependency: @escaping @autoclosure () -> T, for _: T.Type) {
        let id = identifier(for: T.self)
        store[id] = dependency
    }
}

private extension DependencyStore {
    typealias Identifier = String

    func identifier<T>(for _: T) -> Identifier {
        String(describing: T.self)
    }
}
