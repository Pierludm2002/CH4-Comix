//
//  ConfettiView.swift
//  Comix!
//
//  Created by Assistant on 31/01/26.
//

import SwiftUI

struct ConfettiView: View {
    @State private var animate = false
    
    // Configurable parameters
    var count: Int = 50
    var colors: [Color] = [.red, .blue, .green, .yellow, .pink, .orange, .purple]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<count, id: \.self) { _ in
                    ConfettiParticle(
                        color: colors.randomElement()!,
                        geometry: geometry
                    )
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ConfettiParticle: View {
    let color: Color
    let geometry: GeometryProxy
    
    @State private var xPosition: CGFloat = 0
    @State private var yPosition: CGFloat = 0
    @State private var rotation: Double = 0
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 10, height: 10)
            .position(x: xPosition, y: yPosition)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                resetAnimation()
            }
    }
    
    private func resetAnimation() {
        // Start position: random X, above the screen Y
        xPosition = CGFloat.random(in: 0...geometry.size.width)
        yPosition = -CGFloat.random(in: 0...100)
        rotation = Double.random(in: 0...360)
        
        // Animation
        withAnimation(
            .interpolatingSpring(stiffness: 50, damping: 5)
            .repeatForever(autoreverses: false)
            .delay(Double.random(in: 0...2))
            .speed(Double.random(in: 0.5...1.5))
        ) {
            yPosition = geometry.size.height + 100 // Fall off screen
            rotation += 360
        }
    }
}

#Preview {
    ConfettiView()
}
