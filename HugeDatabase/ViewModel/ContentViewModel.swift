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
    @Published var status: ModelStatus? = nil
    
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
    
    enum ModelStatus: String {
        case isDownloading
        case downloadComplete
        var description: String {
            switch self {
            case .isDownloading:
                return "Downloading..."
            case .downloadComplete:
                return "Download Complete"
            }
        }
    }
}

