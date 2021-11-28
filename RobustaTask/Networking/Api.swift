//
//  Api.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import Foundation


class Api
{
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
    
    /// Gets all repositories from URL
    /// - Parameter completion: completion handler to handle the returned repositories
    func getAllRepositories(_ completion: (([Repository]) -> Void)?)
    {
        HttpHelper.get(url: baseUrl + ENDPOINTS.repositories.rawValue) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion?([])
                return
            
            case .success(let respData):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
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
    
    
    
    /// Searches for repositories
    /// - Parameters:
    ///   - query: the query to search for
    ///   - completion: completion handler to handle the returned matching repositories
    func searchRepository(query: String, _ completion: (([Repository]) -> Void)?)
    {
        HttpHelper.get(url: baseUrl + ENDPOINTS.search.rawValue, queryParams: ["q": query]) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion?([])
                return
            
            case .success(let respData):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let repositories = try decoder.decode(RepositorySearch.self, from: respData)
                    repositories.items = repositories.items.filter { repo in // filters repos that has the query in their names only (as the api gets all repos with the query in name, description OR Readme)
                        repo.name.lowercased().contains(query.lowercased())
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

