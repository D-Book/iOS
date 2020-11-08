//
//  BookListFlow.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow

class BookListFlow: Flow {
    
    // MARK: - Properties
    var root: Presentable {
        return self.rootViewController
    }

    let rootViewController = UINavigationController()
    private let service: MainService

    // MARK: - Init
    init(withService service: MainService) {
        self.service = service
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    // MARK: - Navigation Switch
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? BookListStep else { return .none }

        switch step {
        case .bookListIsRequired:
            return navigateToBookList()
        }
    }
}

// MARK: - Navigate to BookList
extension BookListFlow {
    private func navigateToBookList() -> FlowContributors {
        let viewModel = BookListViewModel()
        let viewController = BookListViewController.instantiate(withViewModel: viewModel,
                                                                andServices: self.service)
        
        rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController,
                                                 withNextStepper: viewModel))
    }
}
