//
//  ContentViewModel.swift
//  HugeDatabase
//
//  Created by Pierre on 15/12/2022.
//

import Foundation

class ContentViewModel: ObservableObject {
    private var hugeDataBaseService: HugeDataBaseServiceProtocol
    
    @Published var allWords: Word = Word(words: [])
    @Published var isLoading: Bool = false
    
    init(hugeDataBaseService: HugeDataBaseService = HugeDataBaseService()) {
        self.hugeDataBaseService = hugeDataBaseService
    }
    
    @MainActor
    func loadData() async throws -> Word {
        isLoading = true
        
        let allWords = try await hugeDataBaseService.fetchWords()
            isLoading = false
        return allWords
    }
}

