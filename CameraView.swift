import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    @Binding var hazardDetected: Bool
    @Binding var alertMessage: String
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CameraViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CameraViewControllerDelegate {
        var parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }

        func didCaptureImage(_ image: UIImage) {
            // Integrate Core ML here (see HazardDetector.swift)
            HazardDetector.detectHazard(in: image) { result in
                DispatchQueue.main.async {
                    if let hazard = result {
                        self.parent.hazardDetected = true
                        self.parent.alertMessage = hazard
                    } else {
                        self.parent.alertMessage = "No hazard detected."
                    }
                    self.parent.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

// Placeholder for camera controller (implement fully in Xcode)
protocol CameraViewControllerDelegate: AnyObject {
    func didCaptureImage(_ image: UIImage)
}

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    weak var delegate: CameraViewControllerDelegate?
    // Add camera setup code here (AVCaptureSession, etc.)
}