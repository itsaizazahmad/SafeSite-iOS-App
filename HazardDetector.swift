import CoreML
import Vision

class HazardDetector {
    static func detectHazard(in image: UIImage, completion: @escaping (String?) -> Void) {
        guard let model = try? VNCoreMLModel(for: HazardDetectorModel().model) else {
            completion(nil)
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation],
               let topResult = results.first {
                if topResult.confidence > 0.8 {  // Threshold for detection
                    completion("Hazard: \$topResult.identifier)")
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }

        if let ciImage = CIImage(image: image) {
            let handler = VNImageRequestHandler(ciImage: ciImage)
            try? handler.perform([request])
        }
    }
}

// Placeholder model class – replace with your actual .mlmodel
class HazardDetectorModel {
    lazy var model: MLModel = {
        // Load your HazardDetector.mlmodel here
        return try! MLModel(contentsOf: Bundle.main.url(forResource: "HazardDetector", withExtension: "mlmodel")!)
    }()
}