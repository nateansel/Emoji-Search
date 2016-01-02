//
//  EmojiParser.swift
//  Emoji Search
//
//  Created by Chase McCoy on 12/28/15.
//  Copyright © 2015 Nathan Ansel. All rights reserved.
//

// Emoji JSON taken from: https://github.com/muan/emojilib

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
  
  
  
  
  ///
  ///  Parses the JSON file to an array of Emoji objects.
  ///
  /// - author: Nathan Ansel
  /// - returns: An array of Emoji objects
  ///
  func parseEmojiToObjects() -> NSMutableArray {
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
    
    let emojiObjects = NSMutableArray()
    
    for (name, value) in JSON {
      let tempValue = value as! NSDictionary
      let emojiName = (name as! String).stringByReplacingOccurrencesOfString("_", withString: " ")
      let category = (tempValue.objectForKey("category") as! String).stringByReplacingOccurrencesOfString("_", withString: " ")
      emojiObjects.addObject(
        Emoji(name: emojiName.capitalizedString,
          symbol: tempValue.objectForKey("char") as! String,
          catagory: category.capitalizedString,
          keywords: tempValue.objectForKey("keywords") as! NSMutableArray
        )
      )
    }
    
    print("Parsing JSON to Emoji objects complete.")
    
    return emojiObjects
  }
  
  
  
  
  
  func parseEmojiObjectsToJSON(emojiObjects: NSArray) {
    let filePath = NSBundle.mainBundle().pathForResource("emojis", ofType: "json")
    let fileOutput = NSOutputStream(toFileAtPath: filePath!, append: false)
    var JSON = NSData()
    fileOutput?.open()
    
    let saveData = NSMutableDictionary()
    var count = 0
    for item in emojiObjects {
      let emoji = item as! Emoji
      let tempDictionary = NSMutableDictionary()
      tempDictionary.setObject(emoji.keywords, forKey: "keywords")
      tempDictionary.setObject(emoji.symbol, forKey: "char")
      tempDictionary.setObject(emoji.catagory.stringByReplacingOccurrencesOfString(" ", withString: "_"), forKey: "category")
      saveData.setObject(tempDictionary, forKey: emoji.name.stringByReplacingOccurrencesOfString(" ", withString: "_"))
    }
    
    NSJSONSerialization.writeJSONObject(saveData, toStream: fileOutput!, options: .PrettyPrinted, error: nil)
    fileOutput?.close()
    
    print("Parsing Emoji objects to JSON complete.")
    
    var fileString = NSString();
    
    do {
      try fileString = NSString.init(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding)
    }
    catch {
      print("FAILURE")
    }
    
    print(fileString)
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
