//
//  CustomSearchController.swift
//  Emoji Search
//
//  Created by Chase McCoy on 12/29/15.
//  Copyright © 2015 Nathan Ansel. All rights reserved.
//

import UIKit

protocol CustomSearchControllerDelegate {
  func didStartSearching()
  func didTapOnSearchButton()
  func didChangeSearchText(searchText: String)
}

class CustomSearchController: UISearchController, UISearchBarDelegate {
  var customSearchBar: CustomSearchBar!
  var customDelegate: CustomSearchControllerDelegate!
  
  init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarAccentColor: UIColor, searchBarTintColor: UIColor) {
    super.init(searchResultsController: searchResultsController)
    
    configureSearchBar(searchBarFrame, accentColor: searchBarAccentColor, bgColor: searchBarTintColor)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  func configureSearchBar(frame: CGRect, accentColor: UIColor, bgColor: UIColor) {
    customSearchBar = CustomSearchBar(frame: frame, accentColor: accentColor)
    
    customSearchBar.delegate = self
    
    customSearchBar.barTintColor = bgColor
    customSearchBar.tintColor = UIColor.whiteColor()
    customSearchBar.accentColor = accentColor
    customSearchBar.showsBookmarkButton = false
    customSearchBar.showsCancelButton = false
  }
  
  
  
  
  // MARK: UISearchBarDelegate functions
  
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    customDelegate.didStartSearching()
  }
  
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    customDelegate.didTapOnSearchButton()
  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    customDelegate.didChangeSearchText(searchText)
  }


}
