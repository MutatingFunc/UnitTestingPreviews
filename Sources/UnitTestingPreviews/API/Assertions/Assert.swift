import SwiftUI

@discardableResult
public func Assert(_ condition: Bool, message: String) -> some Assertion {
    Test.record(AssertView(condition, message: message))
}

struct AssertView: Assertion {
    var condition: Bool, message: String
    init(_ condition: Bool, message: String) {
        self.condition = condition
        self.message = message
    }
    
    var description: String { message + " ? " }
    var body: some View {
        Text(message) + Text(" ? ").foregroundColor(.purple)
    }
}

struct Assert_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Assert(true, message: "Assert")
                .previewDisplayName("Assert")
            Assert(true, message: "Doof")
                .previewDisplayName("Doof")
        }.previewLayout(.sizeThatFits)
    }
}
