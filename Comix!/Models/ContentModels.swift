//
//  ContentModels.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import SwiftUI
import Foundation

struct Chapter: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let colorName: String
    var isLocked: Bool = true
    let isGuided: Bool
    let steps: [LessonStep]
    
    var images: [String] = []

    var color: Color {
        Color(colorName, bundle: .main)
    }
    
    // MARK: - Hashable & Equatable
    // Essential for navigationDestination to work correctly
    static func == (lhs: Chapter, rhs: Chapter) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct LessonStep: Identifiable, Codable {
    let id: String
    let instruction: String
    let overlayImageName: String?
    let showGrid: Bool
}

/// Fake content for MVP (later replaced by PDF/JSON)
enum SampleContent {
static let chapters: [Chapter] = [
    Chapter(
        id: "ch1",
        title: "Chapter 1 — Skeleton (Basic)",
        colorName: "Chapter1Color",
        isLocked: false,
        isGuided: false,
        steps: [
            LessonStep(
                id: "s1",
                instruction: "Step 1: Draw a LINE OF ACTION (a simple curve like a banana).",
                overlayImageName: nil,
                showGrid: true
            ),
            LessonStep(
                id: "s2",
                instruction: "Step 2: Add the HEAD: a circle resting on the line.",
                overlayImageName: nil,
                showGrid: true
            ),
            LessonStep(
                id: "s3",
                instruction: "Step 3: Add SHOULDERS and PELVIS with two simple lines (horizontal).",
                overlayImageName: nil,
                showGrid: true
            ),
            LessonStep(
                id: "s4",
                instruction: "Step 4: Add arms and legs as LINES. No muscles.",
                overlayImageName: nil,
                showGrid: true
            ),
            LessonStep(
                id: "s5",
                instruction: "Step 5: Check BALANCE: the head must \"fall\" over the supporting foot.",
                overlayImageName: nil,
                showGrid: false
            )
        ],
    ),
    
    Chapter(
        id: "ch2",
        title: "Chapter 2 - Proportions",
        colorName: "Chapter2Color",
        isLocked: false,
        isGuided: true,
        steps: [
            LessonStep(
                id: "s1",
                instruction: "Step 1: Draw a cross between the first 2 lines",
                overlayImageName: "Chapter2/proportions-body",
                showGrid: true
            ),
            LessonStep(
                id: "s2",
                instruction: "Step 2: Draw the HEAD",
                overlayImageName: "Chapter2/proportions",
                showGrid: true
            ),
            LessonStep(
                id: "s3",
                instruction: "Step 3: Draw the SHOULDERS and PELVIS",
                overlayImageName: "Chapter2/proportions-body",
                showGrid: true
            ),
            LessonStep(
                id: "s4",
                instruction: "Step 4: Draw the ARMS and LEGS",
                overlayImageName: "Chapter2/proportions-body",
                showGrid: true
            ),
            LessonStep(
                id: "s5",
                instruction: "Step 5: Check BALANCE: the head must \"fall\" over the supporting foot.",
                overlayImageName: "Chapter2/proportions-body",
                showGrid: false
            )
            
        ],
        images: ["Chapter2/proportions", "Chapter2/proportions-body"]
    ), 

    Chapter(
        id: "ch3",
        title: "Chapter 3 - Head Details",
        colorName: "Chapter3Color",
        isLocked: true,
        isGuided: true,
        steps: [
            LessonStep(
                id: "s1",
                instruction: "Step 1: Draw a cross between the first 2 lines",
                overlayImageName: "Chapter2/proportions-body",
                showGrid: true
            ),
            LessonStep(
                id: "s2",
                instruction: "Step 2: Draw the HEAD",
                overlayImageName: "Chapter2/proportions",
                showGrid: true
            ),
            LessonStep(
                id: "s3",
                instruction: "Step 3: Draw the SHOULDERS and PELVIS",
                overlayImageName: "Chapter2/proportions-body",
                showGrid: true
            ),
            LessonStep(
                id: "s4",
                instruction: "Step 4: Draw the ARMS and LEGS",
                overlayImageName: "Chapter2/proportions-body",
                showGrid: true
            ),
            LessonStep(
                id: "s5",
                instruction: "Step 5: Check BALANCE: the head must \"fall\" over the supporting foot.",
                overlayImageName: "Chapter2/proportions-body",
                showGrid: false
            )
            
        ],
        images: ["Chapter2/proportions", "Chapter2/proportions-body"]
    )
]

}

