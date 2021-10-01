//
//  Observable.swift
//  RunQuestAI
//
//  Created by Андрей Илалов on 01.10.2021.
//  Copyright © 2021 Андрей Илалов. All rights reserved.
//

import Foundation

public class Observable<T> : Disposable {
    
    public typealias Handler = (_ value:T) -> Void
    
    private lazy var handlers:Dictionary<String, Handler> = [:]
    
    public var value:T {
        didSet {
            notifyHandlers(value)
        }
    }
    
    public init(_ value:T) {
        self.value = value
    }
    
    public func bind(_ handler:@escaping Handler) -> ObservationToken {
        let key = UUID().uuidString
        handlers[key] = handler
        let token = ObservationToken(key:key, observable:self)
        handler(value)
        return token
    }

    fileprivate func notifyHandlers(_ value:T) {
        let handlersCopy = handlers.values
        handlersCopy.forEach { $0(value) }
    }
    
    public func removeHandler(by key: String) {
        handlers.removeValue(forKey: key)
    }
    
    public func updateValueWithoutNotification(_ newValue:T) {
        let savedHandlers = handlers
        handlers = [:]
        value = newValue
        handlers = savedHandlers
    }
    
    public func forceNotifyHandlers() {
        notifyHandlers(self.value)
    }
}

public class DisposeBag {
    
    private lazy var observationTokens:Array<ObservationToken> = []
    
    public init() {}
    
    public func add(_ token:ObservationToken) {
        observationTokens.append(token)
    }
    
    public func dispose() {
        let tokens = observationTokens
        observationTokens.removeAll()
        tokens.forEach { $0.dispose() }
    }
    
    deinit {
        dispose()
    }
}

public class ObservationToken {
    
    public let key:String
    
    private(set) weak var observable:Disposable?
    
    public init(key:String, observable:Disposable) {
        self.key = key
        self.observable = observable
    }
    
    public func dispose() {
        observable?.removeHandler(by: key)
    }
}

public extension ObservationToken {
    func dispose(by bag: DisposeBag) {
        bag.add(self)
    }
}
