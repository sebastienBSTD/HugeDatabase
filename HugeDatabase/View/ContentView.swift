//
//  ContentView.swift
//  HugeDatabase
//
//  Created by Sebastien Bastide on 25/10/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: ContentViewModel
    @State private var progress: Double = 0
    @State private var allWords: Word? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack(spacing: 40) {
            if !isLoading {
                Button {
                    Task(operation: {
                        do {
                            let allWords = try await vm.loadData()
                            vm.allWords = allWords
                            isLoading.toggle()
                        } catch {
                            // alert
                        }
                    })
                } label: {
                    Text("Load words")
                        .font(.headline)
                        .withDefaultButtonFormatting()
                }
                .withPressableStyle()
            }
            if isLoading {
                ProgressView("Loading...", value: progress, total: 100)
            }
            if let allWords = allWords {
                Text("\(allWords.words.count)")
            }
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ContentViewModel())
    }
}
