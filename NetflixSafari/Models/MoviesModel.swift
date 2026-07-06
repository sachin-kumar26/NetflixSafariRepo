//
//  MoviesModel.swift
//  NetflixSafari
//
//  Created by Sachin on 06/07/2026.
//

import Foundation



nonisolated struct TrendingMoviesResponseModel:Decodable,Sendable{
    
    let results: [Movies]
    
}

nonisolated struct Movies:Codable, Sendable{
    
        let id: Int
        let original_name: String?
        let media_type: String?
        let original_title: String?
        let poster_path: String?
        let release_date: String?
        let vote_average: Double?
        let vote_count: Int?
        let overview: String?
    
    
}


