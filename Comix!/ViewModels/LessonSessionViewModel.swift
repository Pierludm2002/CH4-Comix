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

    // NOW USING THE CHAPTER DIRECTLY
    let chapter: Chapter

    private let drawingStore: DrawingStore
    private let progressStore: ProgressStore
    
    private var isFinished: Bool = false

    // Updated Init
    init(chapter: Chapter, drawingStore: DrawingStore, progressStore: ProgressStore) {
        self.chapter = chapter
        self.drawingStore = drawingStore
        self.progressStore = progressStore
        load()
    }
    
    var currentStep: LessonStep {
        guard !chapter.steps.isEmpty else {
            return LessonStep(id: "empty", instruction: "No step available.", overlayImageName: nil, showGrid: false)
        }
        // Using chapter.steps
        return chapter.steps[min(stepIndex, chapter.steps.count - 1)]
    }

    var canGoNext: Bool { stepIndex < max(chapter.steps.count - 1, 0) }
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
        isFinished = true
        progressStore.setCompleted(true, for: chapter.id)
        saveProgress()
    }


    func saveProgress() {
        // If finished, reset progress to 0 for next time, otherwise save current step
        let indexToSave = isFinished ? 0 : stepIndex
        progressStore.saveStepIndex(indexToSave, for: chapter.id)
        
        let currentDrawing = self.drawing // Capture current value
        let chapterId = self.chapter.id
        
        Task {
            await drawingStore.save(drawing: currentDrawing, for: chapterId)
        }
    }
    func load() {
        stepIndex = progressStore.loadStepIndex(for: chapter.id)
        if let loaded = drawingStore.load(for: chapter.id) {
            drawing = loaded
        }
    }

    func resetDrawing() {
        drawing = PKDrawing()
        drawingStore.delete(for: chapter.id)
        progressStore.saveStepIndex(stepIndex, for: chapter.id)
    }

    var isCompleted: Bool {
        progressStore.isCompleted(exerciseId: chapter.id)
    }
}
