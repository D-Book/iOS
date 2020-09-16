//
//  BookListViewController.swift
//  D-Book
//
//  Created by 강민석 on 2020/09/02.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let disposeBag = DisposeBag()
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = BookListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
    }
    
    func configureUI() {
        self.definesPresentationContext = true
        self.searchController.searchBar.placeholder = "책 검색하기"
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar

        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.80, green: 0.61, blue: 0.63, alpha: 1.00)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "BarBT_Setting"), style: .plain, target: nil, action: nil)
        
    }
    
    func bindViewModel() {
        searchController.searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.searchButtonClicked
        
        let input = BookListViewModel.Input()
        let output = viewModel.transform(input: input)
        
        
    }
    

}
