//
//  AdventureMapView.swift
//  Comix!
//
//  Created by Pierluigi De Meo on 30/01/26.
//


import SwiftUI

struct AdventureMapView: View {
    
    let chapters = SampleContent.chapters
    var drawingStore: DrawingStore
        var progressStore: ProgressStore
    
    var body: some View {
        ScrollView {
            VStack(spacing: 60) {
                // Iterate over indices
                ForEach(Array(chapters.enumerated()), id: \.element.id) { index, chapter in
                    
                    // Extracted the entire row into a separate view or function
                    MapNodeRow(
                        chapter: chapter,
                        index: index,
                        isLast: index == chapters.count - 1
                    )
                }
            }
            .padding(.top, 50)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Your Journey")
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: Chapter.self) { chapter in
                    
                    ExerciseViewFactory(
                        chapter: chapter,
                        drawingStore: drawingStore,
                        progressStore: progressStore
                    )
                    
                }
    }
}

// MARK: - Extracted Subviews
// Extracting this logic allows the compiler to analyze it separately

struct MapNodeRow: View {
    let chapter: Chapter // Ensure your Chapter model is imported
    let index: Int
    let isLast: Bool
    
    // Calculate offset here to clean up the View
    var nodeOffset: CGFloat {
        index % 2 == 0 ? -50 : 50
    }
    
    var lineOffset: CGFloat {
        index % 2 == 0 ? -25 : 25
    }
    
    var body: some View {
        VStack(spacing: 0) { // Spacing 0 because we handle the line manually
            
            // 1. The Node (Circle + Text)
            VStack(spacing: 10) {
                NavigationLink(value: chapter) {
                    NodeIcon(isLocked: chapter.isLocked)
                }
                //.disabled(chapter.isLocked)
                
                Text(chapter.title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            .offset(x: nodeOffset) // Zig-zag
            
            // 2. The Connection Line
            if !isLast {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 4, height: 40)
                    .offset(x: lineOffset)
                    // Add top padding to visually separate it from text if needed
                    .padding(.top, 10)
            }
        }
    }
}

// Extracting the inner icon further cleans the code
struct NodeIcon: View {
    let isLocked: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isLocked ? Color.gray.opacity(0.3) : Color.blue)
                .frame(width: 80, height: 80)
                .shadow(radius: isLocked ? 0 : 5)
            
            if isLocked {
                Image(systemName: "lock.fill")
                    .foregroundStyle(.gray)
            } else {
                Image(systemName: "star.fill")
                    .foregroundStyle(.white)
                    .font(.title)
            }
        }
    }
}
