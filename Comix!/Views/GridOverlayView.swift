//
//  GridOverlayView.swift
//  Comix!
//
//  Created by Antonio Bonetti on 29/01/26.
//

import SwiftUI

struct GridOverlayView: View {
    // Puoi cambiare questi valori per modificare la griglia
    var step: CGFloat = 40 // Grandezza dei quadrati
    var color: Color = .gray.opacity(0.3) // Colore delle linee
    var lineWidth: CGFloat = 1 // Spessore delle linee

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                // --- Linee Verticali ---
                // "stride" crea un ciclo da 0 alla larghezza saltando di 'step' (40)
                for x in stride(from: 0, to: width, by: step) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                }

                // --- Linee Orizzontali ---
                for y in stride(from: 0, to: height, by: step) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
            }
            .stroke(color, lineWidth: lineWidth) // Applica colore e spessore al tracciato
        }
        // Questo permette ai tocchi di "passare attraverso" la griglia
        // così puoi disegnare sul canvas che sta sotto (o sopra)
        .allowsHitTesting(false)
    }
}

// Anteprima per vedere come appare mentre programmi
#Preview {
    ZStack {
        Color.white
        GridOverlayView(step: 50, color: .blue.opacity(0.5))
    }
}
