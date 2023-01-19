//
//  ReactiveListener.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import Foundation

class Reactive<T> {
    typealias Listener = (T)->()
    private var listener: Listener?
    private var value: T {
        didSet {
            listener?(self.value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    func accept(_ value: T) {
        self.value = value
    }
}
