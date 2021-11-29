//
//  Api.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import Foundation
import UIKit

class Api
{
    private static let RESULTS_PER_PAGE = 10
    private var currentPage = 0 // the current page viewed in this object
    private(set) var isDone = false // whether we fetched all repositories or not
    private static var isRetrieved = false // checks if we already retrieved data from api (this could have been saved to user defaults, cut we assume that there might be new repos every now and then)
    
    /// base api url
    private final let baseUrl = "https://api.github.com"
    
    /// Endpoints used for the API
    private enum ENDPOINTS: String {
        case repositories = "/repositories"
        case search = "/search/repositories"
    }
    
    
    /// Custom decoder that converts results from snake_case to camelCase
    private final let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static let shared = Api()
    
    
    
    /// Gets the repositories for the next page (counter is being held in the object)
    /// - Parameter completion: handler to handle the returned repositories
    func getNextPageRepositories(_ completion: (([Repository]) -> Void)?)
    {
        if self.isDone { completion?([]); return } // if no repos left (we got all repos from all pages)
        
        let currentPage = self.currentPage // if concurrent requests happened, this would not be affected
        self.currentPage += 1
        let returnSavedRepos = { // returns the saved repos from core data
            Repository.fetchSavedRepos(offset: currentPage * Api.RESULTS_PER_PAGE, limit: Api.RESULTS_PER_PAGE) { repos in
                if repos.isEmpty {
                    print("REPO IS EMPTY")
                    self.isDone = true
                }
                completion?(repos)
            }
        }
        
        if Api.isRetrieved { // if we already saved repos to core data
            returnSavedRepos()
            return
        }
        HttpHelper.get(url: baseUrl + ENDPOINTS.repositories.rawValue, headers: ["Authorization": "token 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"]) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion?([])
                return
            
            case .success(let respData):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.userInfo[.managedObjectContext] = ContextManager.viewContext
                    let repositories = try decoder.decode([Repository].self, from: respData)
                    Repository.saveRepos(repos: repositories)
                    Api.isRetrieved = true // so that we don't retrieve again
                    returnSavedRepos() // we fetch again from core data to maintain consistency
                    return
                }
                catch(let error)
                {
                    print(error, error.localizedDescription)
                    let json = try? JSONSerialization.jsonObject(with: respData, options: []) as? [String: Any]
                    print(json)
                    completion?([])
                    return
                }
                return
            }
        }
    }
    
    /// Gets all repositories from URL
    /// - Parameter completion: completion handler to handle the returned repositories
    func getAllRepositories(_ completion: (([Repository]) -> Void)?)
    {
        HttpHelper.get(url: baseUrl + ENDPOINTS.repositories.rawValue, headers: ["Authorization": "token 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"]) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion?([])
                return
            
            case .success(let respData):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.userInfo[.managedObjectContext] = ContextManager.viewContext
                    let repositories = try decoder.decode([Repository].self, from: respData)
                    completion?(repositories)
                }
                catch(let error)
                {
                    print(error, error.localizedDescription)
                    completion?([])
                    return
                }
                return
            }
        }
    }
    
    
    
    /// Gets repository details such as creation date
    /// - Parameters:
    ///   - repository: the repository object
    ///   - completion: handle the repository with details
    func getRepositoryDetails(repository: Repository, _ completion: ((Repository) -> Void)?)
    {
        guard let repoUrl = repository.url else {
            completion?(repository)
            return
        }
        HttpHelper.get(url: repoUrl, headers: ["Authorization": "token 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"], queryParams: nil) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                break
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.userInfo[.managedObjectContext] = ContextManager.viewContext
                    let repositoryDetails = try decoder.decode(Repository.self, from: data)
                    repositoryDetails.update()
                    completion?(repositoryDetails)
                    return
                }
                catch(let error)
                {
                    print(error, error.localizedDescription)
                    completion?(repository)
                    return
                }
            }
        }
    }
    
    /// Searches for repositories
    /// - Parameters:
    ///   - query: the query to search for
    ///   - page: the page number of the search results
    ///   - completion: completion handler to handle the returned matching repositories
    func searchRepository(query: String, page: Int = 0, _ completion: (([Repository]) -> Void)?)
    {
        HttpHelper.get(url: baseUrl + ENDPOINTS.search.rawValue, headers: ["Authorization": "token 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"], queryParams: ["q": query, "per_page": String(Api.RESULTS_PER_PAGE), "page": String(page)]) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion?([])
                return
            
            case .success(let respData):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.userInfo[.managedObjectContext] = ContextManager.viewContext
                    let repositories = try decoder.decode(RepositorySearch.self, from: respData)
                    repositories.items = repositories.items.filter { repo in // filters repos that has the query in their names only (as the api gets all repos with the query in name, description OR Readme)
                        repo.name?.lowercased().contains(query.lowercased()) ?? false
                    }
                    completion?(repositories.items)
                }
                catch(let error)
                {
                    print(error, error.localizedDescription)
                    completion?([])
                    return
                }
                return
            }
        }
    }
}

