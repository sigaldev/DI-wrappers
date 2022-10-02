//
//  Injected.swift
//  DI-wrappers
//
//  Created by Danil Sigal on 30.09.2022.
//

import Foundation

@propertyWrapper
class Injected<T> {
    private var storage: T?

    private let dependencyStore: DependencyStore

    init() {
        dependencyStore = DependencyStore.shared
    }

    var wrappedValue: T {
        if let storage = storage { return storage }
        let object: T = dependencyStore.resolve()
        storage = object
        return object
    }
}
