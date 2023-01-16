//
//  HugeDatabaseApp.swift
//  HugeDatabase
//
//  Created by Sebastien Bastide on 25/10/2022.
//

import SwiftUI

@main
struct HugeDatabaseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ContentViewModel())
        }
    }
}
