//
//  AppDelegate.swift
//  D-Book
//
//  Created by 강민석 on 2020/06/05.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa
import RealmSwift
import KafkaRefresh

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let appStepper = AppStepper()
    var coordinator = FlowCoordinator()
    
    lazy var appService = {
        return MainService()
    }()
    
    lazy var rootFlow: AppFlow = {
        guard let window = window else { fatalError("Cannot get window: UIWindow?") }
        return AppFlow(window: window, service: self.appService)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        self.coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            print("will navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: rx.disposeBag)

        self.coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: rx.disposeBag)
        
        self.coordinator.coordinate(flow: self.rootFlow, with: self.appStepper)
        
        return true
    }
}
