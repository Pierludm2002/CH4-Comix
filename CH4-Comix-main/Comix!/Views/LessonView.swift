//
//  LessonView.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    private let drawingStore = DrawingStore()
    private let progressStore = ProgressStore()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(lesson.title)
                .font(.title2)
                .bold()

            Text("Step-by-step guided lesson. Draw by following the instructions and transparent guides.")
                .foregroundStyle(.secondary)

            Spacer()

            NavigationLink {
                ExerciseViewFactory(lesson: lesson, drawingStore: drawingStore, progressStore: progressStore)
            } label: {
                Text("Start")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Lesson")
        .navigationBarTitleDisplayMode(.inline)
    }
}
