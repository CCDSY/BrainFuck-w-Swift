//
//  main.swift
//  BrainFuck
//
//  Created by CC on 11/10/16.
//  Copyright © 2016 Shiyu Du. All rights reserved.
//

import Foundation

guard CommandLine.arguments.count > 1 else {
    print("Usage: brianfuckc {program filename}")
    exit(0)
}

let programSource: String
do {
    programSource = try String(contentsOfFile: CommandLine.arguments[1])
} catch {
    print(error)
    exit(0)
}

/* Load internal bundle resource starts here */

guard let instructionTableFilePath = Bundle.main.path(forResource: "Instructions", ofType: "plist") else {
    print("Internal Error: Instruction table not found!")
    exit(1)
}
guard let instructionTable = NSDictionary(contentsOfFile: instructionTableFilePath) as? Dictionary<String, String> else {
    print("Internal Error: Instruction table file corrupted!")
    exit(1)
}

guard let programMainStartSourcePath = Bundle.main.path(forResource: "main-start", ofType: "txt") else {
    print("Internal Error: Resource not found!")
    exit(1)
}
guard let programMainStartSource = try? String(contentsOfFile: programMainStartSourcePath) else {
    print("Internal Error: Resource file corrupted!")
    exit(1)
}

guard let programMainEndSourcePath = Bundle.main.path(forResource: "main-end", ofType: "txt") else {
    print("Internal Error: Resource not found!")
    exit(1)
}
guard let programMainEndSource = try? String(contentsOfFile: programMainEndSourcePath) else {
    print("Internal Error: Resource file corrupted!")
    exit(1)
}

guard let programHelperSourcePath = Bundle.main.path(forResource: "Helpers", ofType: "txt") else {
    print("Internal Error: Resource not found!")
    exit(1)
}
guard let programHelperSource = try? String(contentsOfFile: programHelperSourcePath) else {
    print("Internal Error: Resource file corrupted!")
    exit(1)
}

guard let programRegisterSourcePath = Bundle.main.path(forResource: "Register", ofType: "txt") else {
    print("Internal Error: Resource not found!")
    exit(1)
}
guard let programRegisterSource = try? String(contentsOfFile: programRegisterSourcePath) else {
    print("Internal Error: Resource file corrupted!")
    exit(1)
}

let importStatement = "import Foundation\n"

/* Load internal bundle resource ends here */

/* Parse program source file starts here */

var activeLoopCount = 0

var programInstructions = [String]()

for instructionCharacter in programSource.characters {
    if instructionCharacter == "[" {
        activeLoopCount += 1
    } else if instructionCharacter == "]" {
        guard activeLoopCount > 0 else {
            print("Syntax Error: Unexpected ']' encountered without a preceeding '['")
            exit(1)
        }
        
        activeLoopCount -= 1
    }
    
    if let instruction = instructionTable[String(instructionCharacter)] {
        programInstructions.append(instruction)
    }
}

/* Parse program source file ends here */

/* Write generated program source file starts here */

let outputProgramSourceComponents = [importStatement, programRegisterSource, programHelperSource, programMainStartSource, programInstructions.joined(separator: "\n"), programMainEndSource]
let outputProgramSourceString = outputProgramSourceComponents.joined(separator: "\n")

let manager = FileManager.default
//let outputDirectory = manager.userTemporaryDirectoryPath ?? manager.localTemporaryDirectoryPath
guard let outputDirectoryPath = manager.urls(for: .desktopDirectory, in: .userDomainMask).first?.path else {
    print("Fatal Error: Desktop directory path not found!")
    exit(1)
}
let outputSourceFilePath = outputDirectoryPath.appending(pathComponent: "main.swift")

do {
    try outputProgramSourceString.write(toFile: outputSourceFilePath, atomically: true, encoding: .utf8)
} catch {
    print(error)
    exit(1)
}

/* Write generated program source file ends here */
