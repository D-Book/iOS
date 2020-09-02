//
//  BookListViewController.swift
//  D-Book
//
//  Created by 강민석 on 2020/09/02.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        self.navigationItem.largeTitleDisplayMode = .always
        
//        self.searchController.searchResultsUpdater = self
//        self.definesPresentationContext = true
        
        searchController.searchBar.placeholder = "Biblioteket ditt"
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.1)
        searchController.searchBar.scopeButtonTitles = ["Apple Music", "Biblioteket ditt"]

//        let searchBar = UISearchBar()
//        searchBar.placeholder = "Biblioteket ditt"
//        searchBar.showsScopeBar = true
//        searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.1)
//        searchBar.scopeButtonTitles = ["Apple Music", "Biblioteket ditt"]
        
        

        // To change UISegmentedControl color only when appeared in UISearchBar
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .clear

        self.navigationItem.titleView = searchController.searchBar

//        searchController.hidesNavigationBarDuringPresentation = false
        
    }
    

}
