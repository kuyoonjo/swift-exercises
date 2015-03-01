//
//  NSString+split.swift
//  Say
//
//  Created by Yu Chen on 3/1/15.
//  Copyright (c) 2015 Yu Chen. All rights reserved.
//
import Foundation

extension String {
    func split(splitter: String) -> Array<String> {
        let regEx = NSRegularExpression(pattern: splitter, options: NSRegularExpressionOptions(), error: nil)
        let stop = "<String+split:Splitter>"
        let modifiedString = regEx!.stringByReplacingMatchesInString(self, options: NSMatchingOptions(), range: NSMakeRange(0, countElements(self)), withTemplate: stop)
        return modifiedString.componentsSeparatedByString(stop)
    }
}
