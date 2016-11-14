//
//  FileManager+.swift
//  BrainFuck
//
//  Created by CC on 11/14/16.
//  Copyright © 2016 Shiyu Du. All rights reserved.
//

import Foundation

let bundleIdentifier = "com.shiyu.du.brainfuckc"

extension FileManager {
    
    /// Get the temporary directory recomended to use by Apple.
    /// Tihs is usually in a folder like "~/Library/Caches/",
    /// but sometimes it's in a sandbox environment.
    var userTemporaryDirectoryPath: String? {
        return urls(for: .cachesDirectory, in: .userDomainMask).first?.path.appending(pathComponent: bundleIdentifier)
    }
    
    /// Get the local temporary directory path.
    /// This is usually in "/var/folders/".
    var localTemporaryDirectoryPath: String {
        return NSTemporaryDirectory().appending(pathComponent: bundleIdentifier)
    }
    
}
