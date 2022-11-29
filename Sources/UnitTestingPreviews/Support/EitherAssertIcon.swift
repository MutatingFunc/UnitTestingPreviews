import SwiftUI

struct EitherAssertIcon: View {
    var condition: Bool
    var body: some View {
        Group {
            if condition {
                Label("If true path", systemImage: "diamond.lefthalf.filled")
            } else {
                Label("If false path", systemImage: "diamond.righthalf.filled")
            }
        }
        .labelStyle(.iconOnly)
    }
}

struct EitherAssertIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EitherAssertIcon(condition: true)
                .previewDisplayName("True")
            EitherAssertIcon(condition: false)
                .previewDisplayName("False")
        }.previewLayout(.sizeThatFits)
    }
}
