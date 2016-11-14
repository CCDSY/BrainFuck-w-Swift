//
//  SyntaxError.swift
//  BrainFuck
//
//  Created by CC on 11/14/16.
//  Copyright © 2016 Shiyu Du. All rights reserved.
//

import Foundation

struct SyntaxError: Error {
    
    var localizedDescription: String
    
    init(description: String) {
        localizedDescription = description
    }
    
}
