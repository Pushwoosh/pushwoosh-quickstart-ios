//
//  ContentView.swift
//  customBanner
//
//  Created by André Kis on 18.11.25.
//

import SwiftUI

struct ContentView: View {
    @State private var isGlowing = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.0, blue: 0.3),
                    Color(red: 0.2, green: 0.0, blue: 0.5),
                    Color(red: 0.05, green: 0.0, blue: 0.2)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Pushwoosh Inc.")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .cyan, radius: isGlowing ? 20 : 10)
                    .shadow(color: .blue, radius: isGlowing ? 30 : 15)
                    .shadow(color: .purple, radius: isGlowing ? 40 : 20)
                    .scaleEffect(isGlowing ? 1.05 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true),
                        value: isGlowing
                    )
                    .padding(.bottom, 50)
            }
        }
        .onAppear {
            isGlowing = true
        }
    }
}

#Preview {
    ContentView()
}
