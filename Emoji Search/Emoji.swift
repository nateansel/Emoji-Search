//
//  Emoji.swift
//  Emoji Search
//
//  Created by Nathan Ansel on 12/28/15.
//  Copyright © 2015 Nathan Ansel. All rights reserved.
//

import Foundation


/// 
/// An object used to store emoji and their searchable data
///
/// - author Nathan Ansel
class Emoji {
  var name     = ""
  var symbol   = ""
  var catagory = ""
  var keywords = NSMutableArray()
  
  init (name: String, symbol: String, catagory: String, keywords: NSMutableArray) {
    self.name     = name
    self.symbol   = symbol
    self.catagory = catagory
    self.keywords = keywords
  }
}
