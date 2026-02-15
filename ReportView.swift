import SwiftUI

struct ReportView: View {
    @State private var reports: [String] = ["Hazard reported at Site A - 2024-10-01", "No issues at Site B"]

    var body: some View {
        List(reports, id: \.self) { report in
            Text(report)
        }
        .navigationTitle("Reports")
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}