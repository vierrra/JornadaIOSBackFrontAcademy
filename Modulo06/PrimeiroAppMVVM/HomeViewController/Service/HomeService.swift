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
    
    public func getHomeDataURLSession(completion: @escaping (Result<HomeData, Error>) -> Void) {
        let urlString: String = "https://run.mocky.io/v3/ef04b46e-b395-464e-95bd-7de3dab23413"
        
        guard let url = URL(string: urlString) else { 
            completion(.failure(NSError(domain: "URL inválida", code: 1, userInfo: nil)))
            return
        }
        
        // Aqui, não precisamos especificar o httpMethod, pois como já estamos utilizando o método "dataTask"da classe "URLSession", ele automaticamente
        // já faz a requisição HTTP do tipo "GET" por padrão.
        //Porém se precisarmos de outros métodos HTTP, como "POST", "PUT" ou "DELETE", é necessário criar uma instancia de "URLRequest".
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let dataResult = data else { 
                completion(.failure(NSError(domain: "Error Data", code: 1, userInfo: nil)))
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200  {
                do {
                    let homeData: HomeData = try JSONDecoder().decode(HomeData.self, from: dataResult)
                    completion(.success(homeData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                    return
                }
            }
        }
        
        task.resume()
    }
}
