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
    
    var body: some View {
        VStack(spacing: 40) {
            if !vm.isLoading {
                Button {
                    Task(operation: {
                        do {
                            let allWords = try await vm.loadData()
                            vm.allWords = allWords
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
            if vm.isLoading {
                ProgressView("Loading...", value: progress, total: 100).progressViewStyle(.circular)
            }
            Text("\(vm.allWords.words.count) mots")
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ContentViewModel())
    }
}
