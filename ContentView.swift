import SwiftUI

struct ContentView: View {
    @State private var showCamera = false
    @State private var hazardDetected = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("SafeSite: Safety Reporting App")
                    .font(.title)
                    .padding()

                Button("Capture Hazard") {
                    showCamera = true
                }
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $showCamera) {
                    CameraView(hazardDetected: $hazardDetected, alertMessage: $alertMessage)
                }

                if hazardDetected {
                    Text("Hazard Detected: \$alertMessage)")
                        .foregroundColor(.red)
                        .padding()
                }

                NavigationLink(destination: ReportView()) {
                    Text("View Reports")
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("SafeSite")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}