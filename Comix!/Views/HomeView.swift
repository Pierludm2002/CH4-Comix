//
//  HomeView.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import SwiftUI

struct HomeView: View {
    let chapters = SampleContent.chapters
    @StateObject var drawingStore = DrawingStore()
    @StateObject var progressStore = ProgressStore()

    var body: some View {
        NavigationStack {
            AdventureMapView(
                drawingStore: drawingStore,
                progressStore: progressStore
            )
        }
    }
}

/*
 struct ChapterDetailView: View {
 let chapter: Chapter
 private let progressStore = ProgressStore()
 private let drawingStore = DrawingStore()
 
 @State private var isEditingImage: Bool = false
 
 
 var body: some View {
 ScrollView {
 VStack{
 
 ForEach(chapter.images, id: \.self){ image in
 Image(image)
 .resizable()
 .scaledToFit()
 .frame(width: 300, height: 300)
 .background(Color.clear)
 .cornerRadius(12)
 .overlay(
 RoundedRectangle(cornerRadius: 12)
 .stroke(Color.gray.opacity(0.3), lineWidth: 1) // Bordo sottile opzionale
 )
 }
 
 ForEach(chapter.lessons) { lesson in
 NavigationLink {
 ExerciseViewFactory(lesson: lesson, drawingStore: drawingStore, progressStore: progressStore)
 } label: {
 HStack{
 LessonCircle(lesson: lesson,
 color: chapter.color,
 isCompleted: progressStore.isCompleted(exerciseId: lesson.id))
 }
 .padding()
 .background(Color.blue)
 .cornerRadius(12)
 .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
 }
 .buttonStyle(PlainButtonStyle())
 }
 .padding(.horizontal)
 }
 }
 .navigationTitle(chapter.title)
 }
 }
 
 struct LessonCircle: View {
 let lesson: Lesson
 let color: Color
 let isCompleted: Bool
 
 var body: some View {
 VStack(spacing: 8) {
 
 Text(lesson.title)
 .font(.footnote)
 .multilineTextAlignment(.center)
 .foregroundStyle(.primary)
 .frame(maxWidth: 110)
 }
 .contentShape(Rectangle())
 }
 }
 */
 /// Small "factory" to create ExerciseView with dependencies (store)
struct ExerciseViewFactory: View {
    @StateObject private var vm: LessonSessionViewModel
    
    // Init takes Chapter
    init(chapter: Chapter, drawingStore: DrawingStore, progressStore: ProgressStore) {
        _vm = StateObject(wrappedValue: LessonSessionViewModel(
            chapter: chapter, 
            drawingStore: drawingStore,
            progressStore: progressStore
        ))
    }
    
    var body: some View {
        ExerciseView(vm: vm)
    }
}

