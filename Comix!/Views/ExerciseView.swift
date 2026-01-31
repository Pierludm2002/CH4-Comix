import SwiftUI

struct ExerciseView: View {
    @ObservedObject var vm: LessonSessionViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var isEditingImage: Bool = false
    @State private var showConfetti: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 12) {

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(vm.chapter.title).font(.headline)
                        Text("Step \(vm.stepIndex + 1) of \(vm.chapter.steps.count)")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if (vm.chapter.isGuided) {
                        Toggle("Move Guide", isOn: $isEditingImage)
                            .labelsHidden()
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            .overlay(Text(isEditingImage ? "Done" : "Move").font(.caption).offset(y: 20))
                    }

                    if vm.isCompleted {
                        Text("✅ Completed").font(.subheadline)
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

                // --- BOTTOM BUTTONS ---
                HStack(spacing: 12) {
                    Button("Back") {
                        vm.prevStep()
                        resetView()
                    }
                    .disabled(!vm.canGoBack)

                    Button("Reset") {
                        vm.resetDrawing()
                        resetView()
                    }

                    Spacer()

                    Button(vm.canGoNext ? "Next" : "Finish") {
                        if vm.canGoNext {
                            vm.nextStep()
                            resetView()
                        } else {
                            vm.finishLesson()
                            showConfetti = true
                            // Auto-dismiss after 3 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                dismiss()
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                // High Z-Index to ensure buttons are ALWAYS on top,
                // even if clipping fails (extra safety).
                .zIndex(100)

            }
            // ZStack content end
            
            if showConfetti {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ConfettiView()
                    
                    Text("Good Job!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .shadow(radius: 10)
                        .scaleEffect(1.2)
                }
                .allowsHitTesting(false) // Let user tap elsewhere if needed, though mostly visual
                .zIndex(200) // Ensure it's on top of everything
            }
        }

        .onChange(of: vm.drawing) { _, _ in vm.saveProgress() }
        .onDisappear { vm.saveProgress() }
        .navigationTitle("Lesson")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func resetView() {
        isEditingImage = false
    }
}
