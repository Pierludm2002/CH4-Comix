//
//  LessonView.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import SwiftUI
/*
struct LessonView: View {
    let lesson: Lesson
    private let drawingStore = DrawingStore()
    private let progressStore = ProgressStore()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(lesson.title)
                .font(.title2)
                .bold()

            Text("Lezione guidata passo passo. Disegna seguendo le istruzioni e le guide trasparenti.")
                .foregroundStyle(.secondary)

            Spacer()

            NavigationLink {
                ExerciseViewFactory(lesson: lesson, drawingStore: drawingStore, progressStore: progressStore)
            } label: {
                Text("Inizia")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Lezione")
        .navigationBarTitleDisplayMode(.inline)
    }
}
*/
// Nota: la nuova ExerciseViewFactory è già definita in HomeView.swift.
// Non ridichiararla qui per evitare "Invalid redeclaration".
