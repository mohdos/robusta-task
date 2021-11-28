//
//  ViewController.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Api.shared.getAllRepositories { repos in
            print(repos.count)
        }
        
        Api.shared.searchRepository(query: "xy") { repos in
            print(repos.count)
        }
    }


}

