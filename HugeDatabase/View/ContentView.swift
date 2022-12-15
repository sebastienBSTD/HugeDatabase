//
//  ContentView.swift
//  HugeDatabase
//
//  Created by Sebastien Bastide on 25/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var progress: Double = 0
    
    var body: some View {
        VStack(spacing: 40) {
            ProgressView("Loading...", value: progress, total: 100)

            
            Button {
                
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
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


