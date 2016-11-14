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

var runtime = Runtime(program: program, inputString: inputString)

do {
    try runtime.execute()
} catch {
    print(error)
}

print()
print()
