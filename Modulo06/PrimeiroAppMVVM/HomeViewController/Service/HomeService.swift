//
//  HomeService.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 07/09/24.
//

import Foundation

class HomeService {
    
    public func getHomeDataMock(completion: @escaping (Result<HomeData, Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "HomeData", withExtension: "json") {
            do {
               let data = try Data(contentsOf: url)
                let homeData: HomeData = try JSONDecoder().decode(HomeData.self, from: data)
                completion(.success(homeData))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
