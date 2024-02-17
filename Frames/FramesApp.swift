//
//  FramesApp.swift
//  Frames
//
//  Created by John Daniel Norombaba on 2/17/24.
//

import SwiftUI

@main
struct FramesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
