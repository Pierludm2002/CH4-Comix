//
//  PencilCanvasView.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import SwiftUI
import PencilKit

struct PencilCanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    var isPencilOnly: Bool = true
    
    var onDraw: (() -> Void)? = nil

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.backgroundColor = .clear
        canvas.isOpaque = false
        canvas.alwaysBounceVertical = false
        canvas.drawingPolicy = isPencilOnly ? .pencilOnly : .anyInput

        // Tool fisso (pochi strumenti = meno confusione)
        canvas.tool = PKInkingTool(.pen, color: .black, width: 6)

        canvas.delegate = context.coordinator
        canvas.drawing = drawing
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if uiView.drawing != drawing {
            uiView.drawing = drawing
        }
    }

    func makeCoordinator() -> Coordinator {
        //Coordinator(drawing: $drawing)
        Coordinator(self)
    }

    final class Coordinator: NSObject, PKCanvasViewDelegate {
        //@Binding var drawing: PKDrawing
        //init(drawing: Binding<PKDrawing>) { _drawing = drawing }

        //func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        //    drawing = canvasView.drawing
        //    onDraw?()
       // }
        
        var parent: PencilCanvasView

                init(_ parent: PencilCanvasView) {
                    self.parent = parent
                }

                func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
                    DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            
                            // 1. Aggiorna il disegno (Binding)
                            self.parent.drawing = canvasView.drawing
                            
                            // 2. Chiama la funzione (che nasconde il coniglio)
                            self.parent.onDraw?()
                        }
                }
    }
}
