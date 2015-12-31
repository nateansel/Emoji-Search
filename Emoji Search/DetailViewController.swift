//
//  DetailViewController.swift
//  Emoji Search
//
//  Created by Nathan Ansel on 12/29/15.
//  Copyright © 2015 Nathan Ansel. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
  
  var emojiObject = Emoji(name: "", symbol: "", catagory: "", keywords: [])
  
  @IBOutlet weak var emojiName: UILabel!
  @IBOutlet weak var emojiSymbol: UILabel!
  @IBOutlet weak var keywords: UILabel!
  
  @IBOutlet weak var textField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    emojiName.text = emojiObject.name
    emojiSymbol.text = emojiObject.symbol
    keywords.text = ""
    for keyword in emojiObject.keywords {
      keywords.text = keywords.text! + (keyword as! String) + "\n"
    }
    
  }
  
  @IBAction func doneButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  @IBAction func addButtonPressed(sender: AnyObject) {
    emojiObject.keywords.addObject(textField.text!)
    textField.resignFirstResponder()
    textField.text = ""
    keywords.text = ""
    for keyword in emojiObject.keywords {
      keywords.text = keywords.text! + (keyword as! String) + "\n"
    }
  }
  
  
}
