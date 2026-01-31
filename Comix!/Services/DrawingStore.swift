//
//  DrawingStore.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import Foundation
import Combine
import PencilKit
import SwiftUI

@MainActor
final class DrawingStore: ObservableObject {
    
    // This property "talks" to the UI.
    // It tracks ONLY which exercises have a drawing saved on disk.
    @Published var existingDrawingIds: Set<String> = []
    
    private let folderURL: URL
    
    init() {
        // 1. Folder setup
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        folderURL = docs.appendingPathComponent("Drawings", isDirectory: true)
        try? FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
        
        // 2. Initial scan: see which files already exist
        loadExistingFileIds()
    }
    
    private func fileURL(for exerciseId: String) -> URL {
        folderURL.appendingPathComponent("\(exerciseId).drawing")
    }
    
    // MARK: - File Management
    
    func save(drawing: PKDrawing, for exerciseId: String) {
        let data = drawing.dataRepresentation()
        do {
            try data.write(to: fileURL(for: exerciseId), options: .atomic)
            
            // Notify UI that a drawing now exists for this ID
            if !existingDrawingIds.contains(exerciseId) {
                existingDrawingIds.insert(exerciseId)
            }
        } catch {
            print("❌ Error saving drawing: \(error)")
        }
    }
    
    func load(for exerciseId: String) -> PKDrawing? {
        // Loading remains "lazy": read from disk only when needed
        let url = fileURL(for: exerciseId)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? PKDrawing(data: data)
    }
    
    func delete(for exerciseId: String) {
        let url = fileURL(for: exerciseId)
        
        // Remove the file
        try? FileManager.default.removeItem(at: url)
        
        // Update the UI
        existingDrawingIds.remove(exerciseId)
    }
    
    func hasDrawing(for exerciseId: String) -> Bool {
        existingDrawingIds.contains(exerciseId)
    }
    
    // MARK: - Private Helpers
    
    /// Scans folder at startup to populate existingDrawingIds Set
    private func loadExistingFileIds() {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            
            // Filter only .drawing files and extract ID (filename without extension)
            let ids = fileURLs
                .filter { $0.pathExtension == "drawing" }
                .map { $0.deletingPathExtension().lastPathComponent }
            
            self.existingDrawingIds = Set(ids)
            
        } catch {
            print("⚠️ No drawings found or folder read error: \(error)")
        }
    }
}

