//
//  ViewController.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import UIKit

class HomeVC: UIViewController {

    private final let CELL_ID = "repoCell"
    private var isLoading = false
    private var isSearching = false
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
    
    private let searchController = UISearchController()
    
    private final let api = Api()
    var repos = [Repository]()
    var searchedRepos = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Repository.deleteAllData()
        self.title = "Repositories"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = self.searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.view.addSubview(tableView)
        tableView.edgeTo(self.view)
        loadNextPage()
        
    }
    
    
    /// Loads the next page of repos
    func loadNextPage()
    {
        isLoading = true
        api.getNextPageRepositories { repos in
            for repo in repos {
                self.repos.append(repo)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.isLoading = false
        }
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? self.searchedRepos.count : self.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as? RepoTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(self.isSearching ? self.searchedRepos[indexPath.row] : self.repos[indexPath.row]) { updatedRepo in
            if self.isSearching {
                self.searchedRepos[indexPath.row] = updatedRepo
            }
            else
            {
                self.repos[indexPath.row] = updatedRepo
            }
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = self.isSearching ? self.searchedRepos[indexPath.row] : self.repos[indexPath.row]
        if repo.createdAt == nil || repo.createdAt!.isEmpty { // if did not load details
            return
        }
        let detailsVC = DetailsVC(repo: repo)
        self.navigationController?.pushViewController(detailsVC, animated: true)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoading && !api.isDone && !isSearching){
            self.loadNextPage()
        }
    }
}

extension HomeVC: UISearchResultsUpdating, UISearchBarDelegate
{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text.count >= 2 else {
            self.isSearching = false
            self.tableView.reloadData()
            return
        }
        api.searchRepository(query: text, page: 0) { repos in
            self.isSearching = true
            self.searchedRepos = repos
            self.tableView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearching = false
        self.tableView.reloadData()
        self.searchedRepos = []
    }
    
}
