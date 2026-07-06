//
//  ApiServices.swift
//  NetflixSafari
//
//  Created by Sachin on 05/07/2026.
//

import Foundation

struct Constants {
    static let apiKey = "697d439ac993538da4e3e60b54e762cd"
    static let baseUrl = "https://api.themoviedb.org"
}

enum APIError:Error{
    case failedToGetData
}

class ApiServices{
    
    static let shated = ApiServices()
    
    func getTrendingMovies(completion:@escaping (Result<[Movies], Error>) -> Void){
        
         guard let url = URL(string:"\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.apiKey)") else{return}
        let request = URLRequest(url: url)
        let task  = URLSession.shared.dataTask(with: request) {data, response, error in
            
            guard let data = data , error == nil else {return}
            do{
                let result = try JSONDecoder().decode(TrendingMoviesResponseModel.self, from: data)
                completion(.success(result.results))
                print(result.results[0].overview ?? "some error occured")
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getTrendingTvs(completion:@escaping (Result<[Movies], Error>) -> Void){
        
        guard let url = URL(string:"\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.apiKey)") else{return}
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {data,response,error in
         guard let data = data, error == nil else{
                completion(.failure(APIError.failedToGetData))
             return
            }
            do{
                let result = try JSONDecoder().decode(TrendingMoviesResponseModel.self,from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    
    func getUpcomingMovies(completion:@escaping (Result<[Movies], Error>) -> Void){
        
        guard let url = URL(string:"\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1") else{return}
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {data,response,error in
         guard let data = data, error == nil else{
                completion(.failure(APIError.failedToGetData))
             return
            }
            do{
                let result = try JSONDecoder().decode(TrendingMoviesResponseModel.self,from: data)
                print(result)
                completion(.success(result.results))

            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion:@escaping (Result<[Movies], Error>) -> Void){
        
        guard let url = URL(string:"\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1") else{return}
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {data,response,error in
         guard let data = data, error == nil else{
                completion(.failure(APIError.failedToGetData))
             return
            }
            do{
                let result = try JSONDecoder().decode(TrendingMoviesResponseModel.self,from: data)
                print(result)
                completion(.success(result.results))

            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion:@escaping (Result<[Movies], Error>) -> Void){
        
        guard let url = URL(string:"\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1") else{return}
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) {data,response,error in
         guard let data = data, error == nil else{
                completion(.failure(APIError.failedToGetData))
             return
            }
            do{
                let result = try JSONDecoder().decode(TrendingMoviesResponseModel.self,from: data)
                print(result)
                completion(.success(result.results))

            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
}

