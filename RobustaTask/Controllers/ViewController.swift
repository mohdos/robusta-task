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
            
//            DispatchQueue.main.async {
//                print(Date())
//                RepositoryDec.saveReposToCoreData(repos: repos)
//                print(Date())
//            }
            
            print(repos.count)
//            Repository.saveRepos(repos: repos)
        }
        
        Api.shared.searchRepository(query: "xy") { repos in
            print(repos.count)
        }
        
//        Repository.deleteAllData()
        Repository.fetchSavedRepos(offset: 0, limit: 500) { repos in
            print(repos.count)
        }
    }


}

