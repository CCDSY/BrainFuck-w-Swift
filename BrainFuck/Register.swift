//
//  Register.swift
//  BrainFuck
//
//  Created by CC on 11/10/16.
//  Copyright © 2016 Shiyu Du. All rights reserved.
//

import Foundation

struct Register {
    
    private var lowerBound: Int = 0
    private var upperBound: Int = 0
    private var currentIndex: Int = 0
    
    private var positiveStorage: [Int] = [0]
    private var negativeStorage: [Int] = []
    
    private subscript(i: Int) -> Int {
        get {
            if i < 0{
                return negativeStorage[-(i + 1)]
            } else {
                return positiveStorage[i]
            }
        } set {
            if i < 0{
                negativeStorage[-(i + 1)] = newValue
            } else {
                positiveStorage[i] = newValue
            }
        }
    }
    
    mutating func set(_ value: Int) {
        self[currentIndex] = value
    }
    
    func get() -> Int {
        return self[currentIndex]
    }
    
    mutating func incrementValue() {
        self[currentIndex] += 1
    }
    
    mutating func decrementValue() {
        self[currentIndex] -= 1
    }
    
    mutating func incrementIndex() {
        currentIndex += 1
        if currentIndex > upperBound {
            upperBound += 1
            positiveStorage.append(0)
        }
    }
    
    mutating func decrementIndex() {
        currentIndex -= 1
        if currentIndex < lowerBound {
            lowerBound -= 1
            negativeStorage.append(0)
        }
    }
    
}
