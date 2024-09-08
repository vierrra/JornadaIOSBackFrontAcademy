//
//  HomeService.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 07/09/24.
//

import Foundation
import Alamofire

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
    
    public func getHomeDataAlamofire(completion: @escaping (Result<HomeData, Error>) -> Void) {
        let url: String = "https://run.mocky.io/v3/ef04b46e-b395-464e-95bd-7de3dab23413"
        AF.request(url, method: .get).validate().responseDecodable(of: HomeData.self) { response in
            
            switch response.result {
            case .success( let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
