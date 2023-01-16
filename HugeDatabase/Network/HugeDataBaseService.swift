//
//  HugeDataBaseService.swift
//  HugeDatabase
//
//  Created by Pierre on 15/12/2022.
//

import Foundation

class HugeDataBaseService: HugeDataBaseServiceProtocol {
    // session to be used to make the API call
    let session: URLSession
    
    var urlString = "https://raw.githubusercontent.com/rosqoes/386264words/main/386264.json"
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func fetchWords() async throws -> Word {
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURLString
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkingError.serverError
        }
        
        let decodedWords = try JSONDecoder().decode(Word.self, from: data)
        return decodedWords
    }
}

protocol HugeDataBaseServiceProtocol {
    func fetchWords() async throws -> Word
}
