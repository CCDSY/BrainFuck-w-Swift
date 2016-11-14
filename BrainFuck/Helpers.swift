//
//  Helpers.swift
//  BrainFuck
//
//  Created by CC on 11/10/16.
//  Copyright © 2016 Shiyu Du. All rights reserved.
//

import Foundation

extension UnicodeScalar {
    
    var intValue: Int { return Int(value) }
    
}

extension String {
    
    func lastIndex(where predicate: (Character) throws -> Bool) rethrows -> Index? {
        var i = index(before: endIndex)
        while i >= startIndex {
            if try predicate(self[i]) {
                return i
            }
            
            i = index(before: i)
        }
        
        return nil
    }
    
    func lastIndex(of target: Character) -> Index? {
        return lastIndex { $0 == target }
    }
    
}

extension BidirectionalCollection {
    
    func last(where predicate: (Iterator.Element) throws -> Bool) rethrows -> Iterator.Element? {
        guard let index = try lastIndex(where: predicate) else { return nil }
        
        return self[index]
    }
    
    func lastIndex(where predicate: (Iterator.Element) throws -> Bool) rethrows -> Index? {
        var i  = endIndex
        while i >= startIndex {
            if try predicate(self[i]) {
                return i
            }
            
            i = index(before: i)
        }
        
        return nil
    }
    
}
