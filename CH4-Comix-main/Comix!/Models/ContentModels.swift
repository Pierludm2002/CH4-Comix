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
            title: "Chapter 1 - Skeleton (base)",
            colorName: "Chapter1Color",
            lessons: [
                Lesson(
                    id: "ch1_l1",
                    title: "Lesson 1 — Structure and stick figure",
                    
                    steps: [
                        LessonStep(
                            id: "s1",
                            instruction: "Step 1: Draw a line of action (a simple curve, like a banana)",
                            overlayImageName: nil,
                            showGrid: true
                        ),
                        LessonStep(
                            id: "s2",
                            instruction:"Step 2: Add the HEAD, a circle resting on the line.",
                            overlayImageName: nil,
                            showGrid: true
                        ),
                        LessonStep(
                            id: "s3",
                            instruction:"Step 3: place SHOULDERS and WAIST with two horizontal lines.",
                            overlayImageName: nil,
                            showGrid: true
                        ),
                        LessonStep(
                            id: "s4",
                            instruction:"Step 4: Add arms and legs like lines. No muscles.",
                            overlayImageName: nil,
                            showGrid: true
                        ),
                        LessonStep(
                            id: "s5",
                            instruction:"Step 5: Check the BALANCE: the head should 'fall' over your supporting foot.",
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
                       title: "Proportions fundamental",
                       steps: [
                            LessonStep(
                                id: "s1",
                                instruction: "Step 1: Draw a circle between the first 2 lines ",
                                overlayImageName: "Chapter2/proportions-body",
                                showGrid: true
                            ),
                            LessonStep(
                                id: "s2",
                                instruction: "Step 2: Add the HEAD, a circle resting on the line.",
                                overlayImageName: "Chapter2/proportions",
                                showGrid: true
                            ),
                            LessonStep(
                                id: "s3",
                                instruction:"Step 3: place SHOULDERS and WAIST with two horizontal lines.",
                                overlayImageName: "Chapter2/proportions"   ,
                                showGrid: true
                            ),
                            LessonStep(
                                id: "s4",
                                instruction: "Step 4: Add arms and legs like lines. No muscles.",
                                overlayImageName: nil,
                                showGrid: true
                            ),
                            LessonStep(
                                id: "s5",
                                instruction: "Step 5: Check the BALANCE: the head should 'fall' over your supporting foot.",
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

