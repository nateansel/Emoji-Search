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
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    emojazz.setObject("🤓", forKey: "nerdbutt")
    emojazz.setObject("🤑", forKey: "moneyface")
    emojazz.setObject("🤗", forKey: "nohands")
    
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
      return emojazz.count
    }
    return filteredEmoji.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    if searchController.searchBar.text! == "" {
      let emojazzNumbers = emojazz.allKeys
      let emoji = emojazz[emojazzNumbers[indexPath.row] as! String] as! String
      cell.textLabel!.text = emoji
    }
    else {
      let emoji = filteredEmoji[indexPath.row] as! String
      cell.textLabel!.text = emoji
    }
    return cell
  }
  
  
  func filterContentForSearchText(searchText: String) {
    filteredEmoji.removeAllObjects()
    for key in emojazz.allKeys {
      if key.lowercaseString.containsString(searchText.lowercaseString) {
        filteredEmoji.addObject(emojazz[key as! String] as! String)
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