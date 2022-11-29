import SwiftUI

struct _AssertionResultIcon: View {
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


struct _AssertionResultIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            _AssertionResultIcon(condition: nil)
                .previewDisplayName("Nil")
            _AssertionResultIcon(condition: true)
                .previewDisplayName("True")
            _AssertionResultIcon(condition: false)
                .previewDisplayName("False")
        }.previewLayout(.sizeThatFits)
    }
}
