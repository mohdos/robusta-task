//
//  HttpHelper.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 28/11/2021.
//

import Foundation


class HttpHelper
{
    
    /// Performs a get request to the specified url
    /// - Parameters:
    ///   - url: the url to perform get request
    ///   - completion: completion handler to handle response/result
    static func `get`(url: String, queryParams: [String: String]? = nil, _ completion: ((_ result: Result<Data, Error>) -> Void)?)
    {
        guard var urlComponents = URLComponents(string: url) else {
            completion?(.failure(CustomErrors.invalidURL))
            return
        }
        urlComponents.queryItems = queryParams?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = urlComponents.url else {
            completion?(.failure(CustomErrors.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared.dataTask(with: request) { respData, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion?(.failure(CustomErrors.custom(description: error.localizedDescription)))
                return
            }
            else if let respData = respData {
                DispatchQueue.main.async {
                    completion?(.success(respData))
                }
            }
            else
            {
                completion?(.failure(CustomErrors.unknownError))
            }
        }
        session.resume()
    }
}

