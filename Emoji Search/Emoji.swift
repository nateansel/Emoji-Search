//
//  Emoji.swift
//  Emoji Search
//
//  Created by Nathan Ansel on 12/28/15.
//  Copyright © 2015 Nathan Ansel. All rights reserved.
//

import Foundation

class Emoji {
  var name     = ""
  var symbol   = ""
  var catagory = ""
  var keywords = NSArray()
  
  init (name: String, symbol: String, catagory: String, keywords: NSArray) {
    self.name     = name
    self.symbol   = symbol
    self.catagory = catagory
    self.keywords = keywords
  }
  
  func compare(otherObject: Emoji) -> NSComparisonResult {
    return name.compare(otherObject.name)
  }
}
