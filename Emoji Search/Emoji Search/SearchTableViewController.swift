//
//  SearchTableViewController.swift
//  Emoji Search
//
//  Created by Nathan Ansel on 12/28/15.
//  Copyright © 2015 Nathan Ansel. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
  
  // MARK: - Properties
  var emojazz = NSMutableDictionary()
  var emojiObjects = NSMutableArray()
  var filteredEmoji = NSMutableArray()
  var filteredCatagories = NSMutableArray()
  let emojiCatagories = NSMutableArray()
  let sortedEmojiObjects = NSMutableArray()
  let searchController = UISearchController(searchResultsController: nil)
  
  
  
  
  // MARK: - Methods
  
  // MARK: Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let parser = EmojiParser()
    emojazz = parser.parseEmoji()
    emojiObjects = parser.parseEmojiToObjects()
    
    for item in emojiObjects {
      if emojiCatagories.indexOfObject((item as! Emoji).catagory) == NSNotFound {
        emojiCatagories.addObject((item as! Emoji).catagory)
        sortedEmojiObjects.addObject(NSMutableArray())
      }
    }
    
    // Sort the emoji objects by name
    emojiObjects.sortUsingComparator({ (firstObject: AnyObject, secondObject: AnyObject) -> NSComparisonResult in
      (firstObject as! Emoji).name.compare((secondObject as! Emoji).name)
    })
    
    // Sort the emoji objects into catagories
    for item in emojiObjects {
      sortedEmojiObjects[emojiCatagories.indexOfObject((item as! Emoji).catagory)].addObject((item as! Emoji))
    }
    
    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    
    tableView.tableHeaderView = searchController.searchBar
  }
  
  
  
  override func viewWillAppear(animated: Bool) {
    searchController.searchBar.becomeFirstResponder()
  }
  
  
  
  
  
  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    if searchController.searchBar.text! == "" {
      return emojiCatagories.count
    }
    return filteredCatagories.count
  }
  
  
  
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.searchBar.text! == "" {
      return sortedEmojiObjects[section].count
    }
    return filteredEmoji[section].count
  }
  
  
  
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    if searchController.searchBar.text! == "" {
      let emoji = sortedEmojiObjects[indexPath.section][indexPath.row] as! Emoji
      cell.textLabel!.text = emoji.symbol
      cell.detailTextLabel!.text = emoji.name
    }
    else {
      let emoji = filteredEmoji[indexPath.section][indexPath.row] as! Emoji
      cell.textLabel!.text = emoji.symbol
      cell.detailTextLabel!.text = emoji.name
    }
    return cell
  }
  
  
  
  
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    UIPasteboard.generalPasteboard().string = cell?.textLabel!.text
    cell?.textLabel!.text = (cell?.textLabel!.text!)! + " - copied!"
    return indexPath
  }
  
  
  
  
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if searchController.searchBar.text! == "" {
      return emojiCatagories[section] as? String
    }
    return filteredCatagories[section] as? String
  }
  
  
  
  
  
  ///
  ///  Search the list of Emoji objects for anything matching the search string
  ///  and put it in the filteredEmoji list for display purposes.
  ///
  /// - author: Nathan Ansel
  /// - parameter searchText: The search string to be used when searching the
  ///                         emoji objects.
  ///
  func filterContentForSearchText(searchText: String) {
    // Clear out the old search
    filteredEmoji.removeAllObjects()
    filteredCatagories.removeAllObjects()
    var addEmoji = false
    
    // For each of the search terms
    for word in searchText.componentsSeparatedByString(" ") {
      // For each of the emoji in the JSON
      for emoji in emojiObjects {
        let emojiObject = emoji as! Emoji
        
        // See if any part of the emoji matches the word if so we will add it
        for keyword in emojiObject.keywords {
          if keyword.lowercaseString.containsString(word.lowercaseString) {
            addEmoji = true
          }
        }
        if !addEmoji
          && (emojiObject.name.lowercaseString.containsString(word.lowercaseString)
              || emojiObject.symbol.containsString(word)) {
          addEmoji = true
        }
        
        // Actually add the emoji object to the list of filtered
        if addEmoji {
          // But first add the catagory if it is a new one
          if filteredCatagories.indexOfObject(emojiObject.catagory) == NSNotFound {
            filteredCatagories.addObject(emojiObject.catagory)
            filteredEmoji.addObject(NSMutableArray())
          }
          // Now grab the index and add the emoji object
          let catagoryIndex = filteredCatagories.indexOfObject(emojiObject.catagory)
          if filteredEmoji[catagoryIndex].indexOfObject(emojiObject) == NSNotFound {
            filteredEmoji[catagoryIndex].addObject(emojiObject)
          }
          // Set this back to false so all emoji don't get added
          addEmoji = false
        }
      }
    }
    // So you can see the changes
    tableView.reloadData()
  }
}








extension SearchTableViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!)
  }
}

extension SearchTableViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
}