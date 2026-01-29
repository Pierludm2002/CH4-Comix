//
//  MovableImage.swift
//  Comix!
//
//  Created by Pierluigi De Meo on 29/01/26.
//

import Foundation
import SwiftUI

struct MovableImage: View {
    var imageName: String
    var isEditing: Bool = true
    
    // Stato locale per posizione e grandezza
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var opacityLogic: Double

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .opacity(opacityLogic) // Applica l'opacità passata da fuori
            .scaleEffect(scale)
            .offset(offset)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 2)
                    .scaleEffect(scale)
                    .offset(offset)
                    .opacity(0.1)
            )
            .gesture(
                // Attiva i gesti SOLO se siamo in modalità editing
                isEditing ?
                SimultaneousGesture(
                    // Gesto Spostamento (Drag)
                    DragGesture()
                        .onChanged { value in
                            offset = CGSize(
                                width: lastOffset.width + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        },
                    // Gesto Zoom (Pinch)
                    MagnificationGesture()
                        .onChanged { value in
                            scale = lastScale * value
                        }
                        .onEnded { _ in
                            lastScale = scale
                        }
                ) : nil
            )
    }
}
