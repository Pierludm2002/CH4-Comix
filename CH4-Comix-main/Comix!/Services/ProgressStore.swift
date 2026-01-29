//
//  ProgressStore.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import Foundation

final class ProgressStore {
    private let defaults = UserDefaults.standard

    private func keyStepIndex(exerciseId: String) -> String { "stepIndex_\(exerciseId)" }
    private func keyCompleted(exerciseId: String) -> String { "completed_\(exerciseId)" }

    func saveStepIndex(_ index: Int, for exerciseId: String) {
        defaults.set(index, forKey: keyStepIndex(exerciseId: exerciseId))
    }

    func loadStepIndex(for exerciseId: String) -> Int {
        defaults.integer(forKey: keyStepIndex(exerciseId: exerciseId))
    }

    func setCompleted(_ completed: Bool, for exerciseId: String) {
        defaults.set(completed, forKey: keyCompleted(exerciseId: exerciseId))
    }

    func isCompleted(exerciseId: String) -> Bool {
        defaults.bool(forKey: keyCompleted(exerciseId: exerciseId))
    }
}
