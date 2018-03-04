//
//  AISALittlePieceOfSwift.swift
//  RunQuestAI
//
//  Created by Андрей Илалов on 04.03.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

import Foundation

@objc class AISWriteLog: NSObject {
    static func A() {
        print("s")
    }
    static func printSomething(text: String?) -> Bool {
        print(text ?? "noText")
        return true
    }
}
