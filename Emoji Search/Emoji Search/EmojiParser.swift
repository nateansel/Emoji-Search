//
//  EmojiParser.swift
//  Emoji Search
//
//  Created by Chase McCoy on 12/28/15.
//  Copyright © 2015 Nathan Ansel. All rights reserved.
//

import UIKit

class EmojiParser {
  func parseEmoji() -> NSMutableDictionary {
    let filePath = NSBundle.mainBundle().pathForResource("emojis", ofType: "json")
    var fileString = NSString();
    var JSON = NSDictionary();
    
    do {
      try fileString = NSString.init(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding)
    }
    catch {
      print("FAILURE")
    }
    
    do {
      try JSON = NSJSONSerialization.JSONObjectWithData(fileString.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
    }
    catch {
      print("FAILURE")
    }
    
    let keywords = NSMutableArray();
    let emojis = NSMutableDictionary();
    
    for (_, value) in JSON {
      let tempKeywords = (value as! NSDictionary).objectForKey("keywords") as! NSArray
      for keyword in tempKeywords {
        if !keywords.containsObject(keyword) {
          keywords.addObject(keyword)
        }
      }
    }
    
    for (_, value) in JSON {
      let tempKeywords = (value as! NSDictionary).objectForKey("keywords") as! NSArray
      for keyword in tempKeywords {
        let chars = NSMutableArray();
        emojis.setObject(chars, forKey: keyword as! String)
      }
    }
    
    for (_, value) in JSON {
      let tempKeywords = (value as! NSDictionary).objectForKey("keywords") as! NSArray
      for keyword in tempKeywords {
        emojis.objectForKey(keyword as! NSString)?.addObject(value.objectForKey("char")!)
      }
    }
    
    return emojis
  }
}
