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
  var filteredEmoji = NSMutableArray()
  var unfilteredEmoji = NSMutableArray()
  let searchController = UISearchController(searchResultsController: nil)
//  var emojiDictionary = NSMutableDictionary()
  
  
  
  
  // MARK: - Methods
  
  // MARK: Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    emojazz.setObject(["🤓","📠"], forKey: "nerdbutt")
//    emojazz.setObject(["🤑"], forKey: "moneyface")
//    emojazz.setObject(["🤗"], forKey: "nohands")
    
    let parser = EmojiParser()
    emojazz = parser.parseEmoji()
    
    
    for key in emojazz.allKeys {
      for emoji in emojazz[key as! String] as! NSArray {
        unfilteredEmoji.addObject(emoji)
      }
    }
    
    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    
    tableView.tableHeaderView = searchController.searchBar
  }
  
  
  
  
  
  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  
  
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.searchBar.text! == "" {
      return unfilteredEmoji.count
    }
    return filteredEmoji.count
  }
  
  
  
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    if searchController.searchBar.text! == "" {
      let emoji = unfilteredEmoji[indexPath.row] as! String
      cell.textLabel!.text = emoji
    }
    else {
      let emoji = filteredEmoji[indexPath.row] as! String
      cell.textLabel!.text = emoji
    }
    return cell
  }
  
  
  
  
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    UIPasteboard.generalPasteboard().string = cell?.textLabel!.text
    cell?.textLabel!.text = (cell?.textLabel!.text!)! + " - copied!"
    return indexPath
  }
  
  
  
  
  
  func filterContentForSearchText(searchText: String) {
    filteredEmoji.removeAllObjects()
    for word in searchText.componentsSeparatedByString(" ") {
      for key in emojazz.allKeys {
        if key.lowercaseString.containsString(word.lowercaseString) {
          for emoji in emojazz[key as! String] as! NSArray {
            if filteredEmoji.indexOfObject(emoji) == NSNotFound {
              filteredEmoji.addObject(emoji)
            }
          }
        }
      }
    }
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