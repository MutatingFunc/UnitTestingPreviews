import SwiftUI

struct AssertionResultView<Content: View>: View {
    var condition: Bool?
    var content: () -> Content
    init(condition: Bool?, @ViewBuilder content: @escaping () -> Content) {
        self.condition = condition
        self.content = content
    }
    
    var body: some View {
        HStack {
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            AssertionResultIcon(condition: condition)
        }
    }
}

struct AssertionResultView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssertionResultView(condition: true) {
                Text("Assert")
            }
            .previewDisplayName("True")
            AssertionResultView(condition: false) {
                Text("Assert")
            }
            .previewDisplayName("False")
        }.previewLayout(.sizeThatFits)
    }
}
