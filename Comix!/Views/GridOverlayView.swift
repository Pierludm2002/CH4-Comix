//
//  GridOverlayView.swift
//  Comix!
//
//  Created by Antonio Bonetti on 29/01/26.
//

import SwiftUI

struct GridOverlayView: View {
    // You can change these values to modify the grid
    var step: CGFloat = 40 // Square size
    var color: Color = .gray.opacity(0.3) // Line color
    var lineWidth: CGFloat = 1 // Line thickness

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                // --- Vertical Lines ---
                // "stride" creates a loop from 0 to width skipping by 'step' (40)
                for x in stride(from: 0, to: width, by: step) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                }

                // --- Horizontal Lines ---
                for y in stride(from: 0, to: height, by: step) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
            }
            .stroke(color, lineWidth: lineWidth) // Apply color and thickness to the path
        }
        // This allows touches to "pass through" the grid
        // so you can draw on the canvas below (or above)
        .allowsHitTesting(false)
    }
}

// Preview to see how it looks while coding
#Preview {
    ZStack {
        Color.white
        GridOverlayView(step: 50, color: .blue.opacity(0.5))
    }
}
