//
//  ViewController.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import UIKit

class HomeVC: UIViewController {

    private final let CELL_ID = "repoCell"
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.register(RepoTVC.self, forCellReuseIdentifier: CELL_ID)
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    
    private final let api = Api()
    var repos = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(tableView)
        tableView.edgeTo(self.view)
        
        api.getNextPageRepositories { repos in
            for repo in repos {
                self.repos.append(repo)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as? RepoTVC else {
            return UITableViewCell()
        }
        cell.configure(repos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = self.repos[indexPath.row]
        print(repo.name)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fview = UIView()
        fview.backgroundColor = .white
        return fview
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepoTVC.CELL_HEIGHT
    }
}
