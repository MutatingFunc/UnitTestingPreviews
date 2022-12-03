import SwiftUI

public struct _AssertionResult<A: Assertion>: Assertion {
    var assertion: A
    init(_ assertion: A) {
        self.assertion = assertion
    }
    
    public var condition: Bool { assertion.condition }
    public var description: String { assertion.description }
    public var body: some View { AssertionResultView(assertion) }
}

struct AssertionResultView<Content: View>: View {
    var condition: Bool?
    var content: () -> Content
    init(_ assertion: Content) where Content: Assertion {
        self.condition = assertion.condition
        self.content = { assertion }
    }
    init(condition: Bool?, @ViewBuilder content: @escaping () -> Content) {
        self.condition = condition
        self.content = content
    }
    
    var body: some View {
        HStack {
            HStack {
                content()
            }.frame(maxWidth: .infinity, alignment: .leading)
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
            AssertionResultView(condition: nil) {
                Text("Assert")
            }
            .previewDisplayName("nil")
        }.previewLayout(.sizeThatFits)
    }
}
