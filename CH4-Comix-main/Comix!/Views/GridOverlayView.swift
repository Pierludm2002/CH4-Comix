//
//  GridOverlayView.swift
//  Comix!
//
//  Created by Antonio Bonetti on 29/01/26.
//

import SwiftUI

struct GridOverlayView: View {
   
    var step: CGFloat = 40
    var color: Color = .gray.opacity(0.3)
    var lineWidth: CGFloat = 1

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                for x in stride(from: 0, to: width, by: step) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                }
                for y in stride(from: 0, to: height, by: step) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
            }
            .stroke(color, lineWidth: lineWidth) // Applica colore e spessore al tracciato
        }
        
        .allowsHitTesting(false)
    }
}


#Preview {
    ZStack {
        Color.white
        GridOverlayView(step: 50, color: .blue.opacity(0.5))
    }
}
