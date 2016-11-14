//
//  String+.swift
//  BrainFuck
//
//  Created by CC on 11/14/16.
//  Copyright © 2016 Shiyu Du. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns a new string made by appending to the receiver a given string.
    ///
    /// - parameter pathComponent: The path component to append to the receiver.
    ///
    /// - returns: A new string made by appending aString to the receiver, preceded if necessary by a path separator.
    func appending(pathComponent: String) -> String {
        return (self as NSString).appendingPathComponent(pathComponent)
    }
    
}
