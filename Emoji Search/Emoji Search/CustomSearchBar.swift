//
//  CustomSearchBar.swift
//  Emoji Search
//
//  Created by Chase McCoy on 12/29/15.
//  Copyright © 2015 Nathan Ansel. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
  var accentColor: UIColor!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init(frame: CGRect, accentColor: UIColor) {
    super.init(frame: frame)
    
    self.frame = frame
    self.accentColor = accentColor
    
    searchBarStyle = UISearchBarStyle.Prominent
    translucent = false
  }
  
  func indexOfSearchFieldInSubviews() -> Int! {
    var index: Int!
    let searchBarView = subviews[0] 
    
    for var i=0; i<searchBarView.subviews.count; ++i {
      if searchBarView.subviews[i] is UITextField {
        index = i
        break
      }
    }
    
    return index
  }
  
  override func drawRect(rect: CGRect) {
    if let index = indexOfSearchFieldInSubviews() {
      let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
      
      searchField.frame = CGRectMake(5.0, 5.0, frame.size.width - 10.0, frame.size.height - 10.0)
      
      searchField.backgroundColor = barTintColor
      searchField.textColor = UIColor.whiteColor()
    }
    
    let startPoint = CGPointMake(0.0, frame.size.height)
    let endPoint = CGPointMake(frame.size.width, frame.size.height)
    let path = UIBezierPath()
    path.moveToPoint(startPoint)
    path.addLineToPoint(endPoint)
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.CGPath
    shapeLayer.strokeColor = accentColor.CGColor
    shapeLayer.lineWidth = 4
    
    layer.addSublayer(shapeLayer)
    
    super.drawRect(rect)
  }

}
