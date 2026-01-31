//
//  ProgressStore.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import Foundation
import Combine

final class ProgressStore: ObservableObject {
    private let defaults = UserDefaults.standard
    
    // This is the key for reactivity!
    // When this Set changes, SwiftUI redraws the view.
    @Published var completedChapterIds: Set<String> = []
    
    init() {
        // On app launch, load everything saved
        loadAllProgress()
    }

    // MARK: - Completion Management (Reactive)
    
    func setCompleted(_ completed: Bool, for exerciseId: String) {
        // 1. Update memory (SwiftUI reacts HERE)
        if completed {
            completedChapterIds.insert(exerciseId)
        } else {
            completedChapterIds.remove(exerciseId)
        }
        
        // 2. Save to disk (persistence)
        defaults.set(completed, forKey: keyCompleted(exerciseId: exerciseId))
    }

    func isCompleted(exerciseId: String) -> Bool {
        // Read from memory (fast and reactive)
        return completedChapterIds.contains(exerciseId)
    }

    // MARK: - Step Index Management (Less critical for global UI)
    
    func saveStepIndex(_ index: Int, for exerciseId: String) {
        // If you want step change to update UI in real-time,
        // uncomment the line below:
        // objectWillChange.send()
        defaults.set(index, forKey: keyStepIndex(exerciseId: exerciseId))
    }

    func loadStepIndex(for exerciseId: String) -> Int {
        defaults.integer(forKey: keyStepIndex(exerciseId: exerciseId))
    }

    // MARK: - Private Helpers
    
    private func keyStepIndex(exerciseId: String) -> String { "stepIndex_\(exerciseId)" }
    private func keyCompleted(exerciseId: String) -> String { "completed_\(exerciseId)" }
    
    private func loadAllProgress() {
        // Here we should ideally load all known chapters.
        // Since UserDefaults with dynamic keys is awkward to scan,
        // for now we load "lazily" or use a trick to populate it.
        
        // NOTE: If you have a known list of chapters (SampleContent.chapters),
        // you could iterate over them in the init to populate the initial Set.
        for chapter in SampleContent.chapters {
             if defaults.bool(forKey: keyCompleted(exerciseId: chapter.id)) {
                 completedChapterIds.insert(chapter.id)
             }
        }
    }
}
