//
//  DrawingStore.swift
//  Comix!
//
//  Created by Antonio Bonetti on 26/01/26.
//

import Foundation
import PencilKit

final class DrawingStore {
    private let folderURL: URL

    init() {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        folderURL = docs.appendingPathComponent("Drawings", isDirectory: true)
        try? FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
    }

    private func fileURL(for exerciseId: String) -> URL {
        folderURL.appendingPathComponent("\(exerciseId).drawing")
    }

    func save(drawing: PKDrawing, for exerciseId: String) {
        let data = drawing.dataRepresentation()
        do {
            try data.write(to: fileURL(for: exerciseId), options: .atomic)
        } catch {
            print("❌ Errore salvataggio drawing: \(error)")
        }
    }

    func load(for exerciseId: String) -> PKDrawing? {
        let url = fileURL(for: exerciseId)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? PKDrawing(data: data)
    }

    func delete(for exerciseId: String) {
        let url = fileURL(for: exerciseId)
        try? FileManager.default.removeItem(at: url)
    }
}

