//
//  IntroFlow.swift
//  D-Book
//
//  Created by 강민석 on 2020/11/07.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import UIKit
import RxFlow

class IntroFlow: Flow {

    // MARK: - Properties
    private let service: MainService

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        // Navigation Bar를 transparent하게
        viewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationBar.shadowImage = UIImage()
        viewController.navigationBar.isTranslucent = true
        return viewController
    }()

    // MARK: - Init
    init(withService service: MainService) {
        self.service = service
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    // MARK: - Navigation Switch
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? IntroStep else { return .none }

        switch step {
        case .signInIsRequired:
            return navigateToSignIn()
        case .signUpIsRequired:
            return navigateToSignUp()
        case .createProfileIsRequired:
            return navigateToCreateProfile()
        case .dismissSignUpIsRequired:
            return dismissSignUp()
        }
    }
}

// MARK: - Navigate to SignIn
extension IntroFlow {
    private func navigateToSignIn() -> FlowContributors {
        let viewModel = SignInViewModel()
        let viewController = SignInViewController.instantiate(withViewModel: viewModel,
                                                              andServices: self.service)

        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController,
                                                 withNextStepper: viewModel))
    }
}

// MARK: - Navigate to SignUp
extension IntroFlow {
    private func navigateToSignUp() -> FlowContributors {
        let viewModel = signUpViewModel()
        let viewController = SignUpViewController.instantiate(withViewModel: viewModel,
                                                              andServices: self.service)

        self.rootViewController.present(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController,
                                                 withNextStepper: viewModel))
    }
}

// MARK: - Navigate to CreateProfile
extension IntroFlow {
    private func navigateToCreateProfile() -> FlowContributors {
        let viewModel = SignInViewModel()
        let viewController = CreateProfileViewController.instantiate(withViewModel: viewModel,
                                                                     andServices: self.service)

        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController,
                                                 withNextStepper: viewModel))
    }
}

// MARK: - Dismiss SignUp
extension IntroFlow {
    private func dismissSignUp() -> FlowContributors {
        if let signUpViewController = self.rootViewController.presentedViewController {
            signUpViewController.dismiss(animated: true)
        }
        return .none
    }
}
