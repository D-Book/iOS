//
//  TabBarFlow.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RxFlow

class TabBarFlow: Flow {

    private let service: MainService
    
    var root: Presentable {
        return rootViewController!
    }

    private weak var rootViewController: UITabBarController?
    
    init(withService service: MainService) {
        self.service = service
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? TabBarStep else { return .none }

        switch step {
        case .tabBarIsRequired:
            return navigateToTabBar()
        }
    }
}

// MARK: - Navigate to TabBar
extension TabBarFlow {
    private func navigateToTabBar() -> FlowContributors {
        let bookListFlow = BookListFlow(withService: self.service)
        let myLibraryFlow = MyLibraryFlow(withService: self.service)

        Flows.use(bookListFlow, myLibraryFlow, when: .created) { [unowned self] (root1, root2: UINavigationController) in

            let tabBarItem1 = UITabBarItem(title: nil, image: R.image.bookListIcon(), selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: nil, image: R.image.myLibraryIcon(), selectedImage: nil)
            
            root1.tabBarItem = tabBarItem1
            root1.title = "책 목록"
            root2.tabBarItem = tabBarItem2
            root2.title = "내 서재"
            
            self.rootViewController?.setViewControllers([root1, root2], animated: true)
        }

        return .multiple(flowContributors: [
            .contribute(withNextPresentable: bookListFlow,
                        withNextStepper: OneStepper(withSingleStep: BookListStep.bookListIsRequired)),
            .contribute(withNextPresentable: myLibraryFlow,
                        withNextStepper: OneStepper(withSingleStep: MyLibraryStep.myLibraryIsRequired))
        ])
    }
}
