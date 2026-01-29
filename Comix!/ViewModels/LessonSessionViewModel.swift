//
//  LessonSessionViewModel.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import SwiftUI
import PencilKit
import Combine

@MainActor
final class LessonSessionViewModel: ObservableObject {
    @Published var stepIndex: Int = 0
    @Published var drawing: PKDrawing = PKDrawing()

    let lesson: Lesson

    private let drawingStore: DrawingStore
    private let progressStore: ProgressStore

    init(lesson: Lesson, drawingStore: DrawingStore, progressStore: ProgressStore) {
        self.lesson = lesson
        self.drawingStore = drawingStore
        self.progressStore = progressStore
        load()
    }
    

    var currentStep: LessonStep {
        guard !lesson.steps.isEmpty else {
            return LessonStep(id: "empty", instruction: "Nessuno step disponibile.", overlayImageName: nil, showGrid: false)
        }
        return lesson.steps[min(stepIndex, lesson.steps.count - 1)]
    }

    var canGoNext: Bool { stepIndex < max(lesson.steps.count - 1, 0) }
    var canGoBack: Bool { stepIndex > 0 }

    func nextStep() {
        guard canGoNext else { return }
        stepIndex += 1
        saveProgress()
    }

    func prevStep() {
        guard canGoBack else { return }
        stepIndex -= 1
        saveProgress()
    }

    func finishLesson() {
        progressStore.setCompleted(true, for: lesson.id)
        saveProgress()
    }

    func saveProgress() {
        drawingStore.save(drawing: drawing, for: lesson.id)
        progressStore.saveStepIndex(stepIndex, for: lesson.id)
    }

    func load() {
        stepIndex = progressStore.loadStepIndex(for: lesson.id)
        if let loaded = drawingStore.load(for: lesson.id) {
            drawing = loaded
        }
    }

    func resetDrawing() {
        drawing = PKDrawing()
        drawingStore.delete(for: lesson.id)
        // Se vuoi cancellare davvero, NON richiamare subito saveProgress (altrimenti risalvi il disegno vuoto)
        progressStore.saveStepIndex(stepIndex, for: lesson.id)
    }

    var isCompleted: Bool {
        progressStore.isCompleted(exerciseId: lesson.id)
    }
}

