import SwiftUI

struct ExerciseView: View {
    @ObservedObject var vm: LessonSessionViewModel
    
    @State private var isEditingImage: Bool = false

    var body: some View {
        VStack(spacing: 12) {

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(vm.lesson.title).font(.headline)
                    Text("Step \(vm.stepIndex + 1) di \(vm.lesson.steps.count)")
                        .foregroundStyle(.secondary)
                }
                Spacer()
                
                Toggle("Sposta Guida", isOn: $isEditingImage)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .overlay(Text(isEditingImage ? "Fatto" : "Sposta").font(.caption).offset(y: 20))
                
                if vm.isCompleted {
                    Text("✅ Completato").font(.subheadline)
                }
            }
            .padding(.horizontal)

            Text(vm.currentStep.instruction)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            ZStack {
                if vm.currentStep.showGrid {
                    GridOverlayView()
                        .opacity(0.18)
                        .allowsHitTesting(false)
                }

                if let name = vm.currentStep.overlayImageName {
                    MovableImage(
                        imageName: name,
                        isEditing: isEditingImage,
                        
                        opacityLogic: isEditingImage ? 1.0 : 0.30
                    )
                    .zIndex(isEditingImage ? 2 : 0)
                }

                PencilCanvasView(
                    drawing: $vm.drawing,
                    isPencilOnly: true,
                    onDraw: nil
                )
                .opacity(isEditingImage ? 0.2 : 1.0)
                .allowsHitTesting(!isEditingImage)
                .zIndex(1)
            }
            
            .background(Color.clear)
            .contentShape(Rectangle())
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isEditingImage ? Color.blue : .gray.opacity(0.2), lineWidth: isEditingImage ? 2 : 1)
            )
            .padding(.horizontal)
            .frame(maxHeight: .infinity)
            .zIndex(0)

            // --- FOOTER BOTTONI ---
            HStack(spacing: 12) {
                Button("Indietro") {
                    vm.prevStep()
                    resetView()
                }
                .disabled(!vm.canGoBack)

                Button("Reset") {
                    vm.resetDrawing()
                    resetView()
                }

                Spacer()

                Button(vm.canGoNext ? "Avanti" : "Fine") {
                    if vm.canGoNext {
                        vm.nextStep()
                        resetView()
                    } else {
                        vm.finishLesson()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            // Z-Index alto per assicurarsi che i bottoni stiano SEMPRE sopra,
            // anche se il clipping fallisse (sicurezza extra).
            .zIndex(100)

        }
        .onChange(of: vm.drawing) { _, _ in vm.saveProgress() }
        .onDisappear { vm.saveProgress() }
        .navigationTitle("Lezione")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func resetView() {
        isEditingImage = false
    }
}
