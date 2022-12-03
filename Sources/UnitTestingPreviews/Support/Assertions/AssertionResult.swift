import SwiftUI

public struct _AssertionResult<Condition: Assertion>: Assertion {
    var assertion: Condition
    public var condition: Bool {
        assertion.condition
    }
    public var description: String { assertion.description }
    public var body: some View {
        AssertionResultView(condition: condition) {
            assertion
        }
    }
}

struct _AssertionResult_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            _AssertionResult(assertion: Assert(true, message: "Assert"))
                .previewDisplayName("True")
            _AssertionResult(assertion: Assert(false, message: "Assert"))
                .previewDisplayName("False")
        }.previewLayout(.sizeThatFits)
    }
}
