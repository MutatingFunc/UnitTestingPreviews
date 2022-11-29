import SwiftUI

struct AssertionResultIcon: View {
    var condition: Bool?
    var body: some View {
        Group {
            switch condition {
            case nil:
                Label("Running…", systemImage: "questionmark.diamond")
                    .foregroundColor(.gray)
            case true?:
                Label("Passed", systemImage: "checkmark.diamond")
                    .foregroundColor(.green)
            case false?:
                Label("Failed", systemImage: "xmark.diamond")
                    .foregroundColor(.red)
            }
        }.labelStyle(.iconOnly)
    }
}


struct AssertionResultIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssertionResultIcon(condition: nil)
                .previewDisplayName("Nil")
            AssertionResultIcon(condition: true)
                .previewDisplayName("True")
            AssertionResultIcon(condition: false)
                .previewDisplayName("False")
        }.previewLayout(.sizeThatFits)
    }
}
