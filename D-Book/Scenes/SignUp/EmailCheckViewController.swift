//
//  EmailCheckViewController.swift
//  D-Book
//
//  Created by 강민석 on 2020/08/26.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EmailCheckViewController: UIViewController {

    
    @IBOutlet weak var checkCodeField: UITextField!
    
    let disposeBag = DisposeBag()
    let viewModel = EmailCheckViewModel()
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
