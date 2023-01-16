//
//  NetworkingError.swift
//  HugeDatabase
//
//  Created by Pierre on 15/12/2022.
//

import Foundation

enum NetworkingError: Error {
    case serverError
    case invalidURLString
    
    var errorDescription: String? {
        switch self {
        case .invalidURLString: return "[🔥] Bad string for URL"
        case .serverError : return "[🔥] Server Error"
        }
    }
}
