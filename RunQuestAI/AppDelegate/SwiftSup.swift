//
//  SwiftSup.swift
//  RunQuestAI
//
//  Created by Андрей Илалов on 01.10.2021.
//  Copyright © 2021 Андрей Илалов. All rights reserved.
//

import Foundation

class HelperToArray<T> {
    private var value: T
    private let queue = DispatchQueue(label: "arrayRuledQueue",
                                      qos: .userInteractive,
                                      attributes: .concurrent)
    
    func getValue(get: (T) -> Void) {
        queue.sync { [weak self] in
            guard let self = self else { return }
            get(self.value)
        }
    }
    
    func setValue(v: T) {
        queue.sync { [weak self] in
            guard let self = self else { return }
            self.value = v
        }
    }
}
