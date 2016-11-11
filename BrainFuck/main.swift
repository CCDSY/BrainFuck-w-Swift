//
//  main.swift
//  BrainFuck
//
//  Created by CC on 11/10/16.
//  Copyright © 2016 Shiyu Du. All rights reserved.
//

import Foundation

guard CommandLine.arguments.count > 1 else {
    print("Usage: brianfuck {program filename} [{input filename}]")
    exit(0)
}

let program: String
let inputString: String
do {
    program = try String(contentsOfFile: CommandLine.arguments[1])
    
    if CommandLine.arguments.count > 2 {
        inputString = try String(contentsOfFile: CommandLine.arguments[2])
    } else {
        var line: String? = nil
        while line == nil {
            print("Pending for input...")
            line = readLine()
        }
        inputString = line!
        
        print()
        print()
    }
} catch {
    print(error)
    exit(0)
}

print("Executing program: ")
print(program)
print()

print("With inputs: ")
print(inputString)
print()

var register = Register()
var executionStack: [String.Index] = []
var skipping = false
var inputs = inputString.unicodeScalars.makeIterator()

var characterIndex = program.startIndex
while characterIndex != program.endIndex {
    switch program[characterIndex] {
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
        guard let character = UnicodeScalar(register.get()) else { break }
        print(character.description, terminator: "")
    case "[":
        if register.get() == 0 {
            skipping = true
        } else {
            executionStack.append(characterIndex)
        }
    case "]":
        if skipping == true {
            skipping = false
        } else {
            guard let last = executionStack.popLast() else {
                print("Unexpected ']' encountered without a preceeding '['")
                exit(0)
            }
            
            characterIndex = last
            continue
        }
    default:
        break
    }
    
    characterIndex = program.index(after: characterIndex)
}

print()
print()
