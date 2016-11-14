//
//  Runtime.swift
//  BrainFuck
//
//  Created by CC on 11/14/16.
//  Copyright © 2016 Shiyu Du. All rights reserved.
//

import Foundation

struct Runtime {
    
    private var register = Register()
    private var inputs: String.UnicodeScalarView.Iterator
    
    private let instructions: [Character]
    
    init(program: String, inputString: String) {
        self.inputs = inputString.unicodeScalars.makeIterator()
        self.instructions = Array(program.characters)
    }
    
    mutating func execute() throws {
        var index = 0
        while index < instructions.count {
            let instruction = instructions[index]
            
            if instruction == "[" {
                index = executeLoop(starting: index + 1) + 1
            } else {
                execute(instruction: instruction)
                
                index += 1
            }
        }
    }
    
    private mutating func executeLoop(starting startIndex: Int) -> Int {
        while true {
            var index = startIndex
            while index < instructions.count {
                let instruction = instructions[index]
                
                if instruction == "[" {
                    index = executeLoop(starting: index + 1) + 1
                } else if instruction == "]" {
                    if register.get() == 0 {
                        return index
                    } else {
                        break
                    }
                } else {
                    execute(instruction: instruction)
                    
                    index += 1
                }
            }
            // FIXME: 如果有'['没有']'就会无限循环。应该改成抛SyntaxError
        }
    }
    
    private mutating func execute(instruction: Character) {
        switch instruction {
        case ">":
            register.incrementIndex()
        case "<":
            register.decrementIndex()
        case "+":
            register.incrementValue()
        case "-":
            register.decrementValue()
        case ",":
            register.set(inputs.next()?.intValue ?? 0)
        case ".":
            print(UnicodeScalar(register.get()) ?? "", terminator: "")
        default:
            break
        }
    }
    
}
