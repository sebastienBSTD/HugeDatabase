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
    
    var body: some View {
        VStack(spacing: 40) {
            ProgressView("Loading...", value: progress, total: 100)
            
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
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 10)
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

