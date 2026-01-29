//
//  ContentModels.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import SwiftUI
import Foundation

struct Chapter: Identifiable, Codable {
    let id: String
    let title: String
    let colorName: String
    var images: [String] = [""]
    let lessons: [Lesson]
    

    var color: Color {
        Color(colorName, bundle: .main)
    }
}



struct Lesson: Identifiable, Codable {
    let id: String
    let title: String
    let steps: [LessonStep]
    let isGuided: Bool
}

struct LessonStep: Identifiable, Codable {
    let id: String
    let instruction: String
    let overlayImageName: String?
    let showGrid: Bool
}

/// Contenuto finto per MVP (poi lo sostituiamo con PDF/JSON)
enum SampleContent {
    static let chapters: [Chapter] = [
        Chapter(
            id: "ch1",
            title: "Capitolo 1 — Scheletro (base)",
            colorName: "Chapter1Color",
            lessons: [
                Lesson(
                    id: "ch1_l1",
                    title: "Lezione 1 — Stick figure e struttura",
                    
                    steps: [
                        LessonStep(
                            id: "s1",
                            instruction: "Step 1: Disegna una LINEA DI AZIONE (una curva semplice tipo banana).",
                            overlayImageName: nil,
                            showGrid: true
                        ),
                        LessonStep(
                            id: "s2",
                            instruction: "Step 2: Aggiungi la TESTA: un cerchio appoggiato alla linea.",
                            overlayImageName: nil,
                            showGrid: true
                        ),
                        LessonStep(
                            id: "s3",
                            instruction: "Step 3: Metti SPALLE e BACINO con due linee semplici (orizzontali).",
                            overlayImageName: nil,
                            showGrid: true
                        ),
                        LessonStep(
                            id: "s4",
                            instruction: "Step 4: Aggiungi braccia e gambe come LINEE. Niente muscoli.",
                            overlayImageName: nil,
                            showGrid: true
                        ),
                        LessonStep(
                            id: "s5",
                            instruction: "Step 5: Controlla l’EQUILIBRIO: la testa deve “cadere” sopra il piede d’appoggio.",
                            overlayImageName: nil,
                            showGrid: false
                        )
                    ],
                    isGuided: false
                )
            ]
        ),
        
        Chapter(
            id:"ch2",
            title: "Chapter 2 - Proportions",
            colorName: "Chapter2Color",
            images: ["Chapter2/proportions" , "Chapter2/proportions-body"],
            lessons: [
                Lesson(id: "2",
                       title: "Proportion fundamental",
                       steps: [
                            LessonStep(
                                id: "s1",
                                instruction: "Step 1: Draw a circle between the first 2 lines ",
                                overlayImageName: "Chapter2/proportions-body",
                                showGrid: true
                            ),
                            LessonStep(
                                id: "s2",
                                instruction: "Step 2: Aggiungi la TESTA: un cerchio appoggiato alla linea.",
                                overlayImageName: "Chapter2/proportions",
                                showGrid: true
                            ),
                            LessonStep(
                                id: "s3",
                                instruction: "Step 3: Metti SPALLE e BACINO con due linee semplici (orizzontali).",
                                overlayImageName: "Chapter2/proportions"   ,
                                showGrid: true
                            ),
                            LessonStep(
                                id: "s4",
                                instruction: "Step 4: Aggiungi braccia e gambe come LINEE. Niente muscoli.",
                                overlayImageName: nil,
                                showGrid: true
                            ),
                            LessonStep(
                                id: "s5",
                                instruction: "Step 5: Controlla l’EQUILIBRIO: la testa deve “cadere” sopra il piede d’appoggio.",
                                overlayImageName: "Chapter2/proportions-body",
                                showGrid: false
                            )
                        ],
                       isGuided: true
                    )
            ]
        )
    ]
}

