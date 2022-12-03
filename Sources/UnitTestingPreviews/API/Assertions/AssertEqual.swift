import SwiftUI

@discardableResult
public func AssertEqual<Value: Equatable>(_ actual: Value, _ expectation: Value) -> some Assertion {
    Test.record(AssertEqualView(actual, expectation))
}

struct AssertEqualView<Value: Equatable>: Assertion {
    var actual: Value, expectation: Value
    init(_ actual: Value, _ expectation: Value) {
        self.actual = actual
        self.expectation = expectation
    }
    
    var condition: Bool {
        actual == expectation
    }
    var description: String { String(describing: actual) + " = " + String(describing: expectation) }
    var body: some View {
        Text(String(describing: actual))
        + Text(" = ").foregroundColor(.purple)
        + Text(String(describing: expectation))
    }
}

struct AssertEqual_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssertEqual("Doof", "Doof")
                .previewDisplayName("Strings")
            AssertEqual(true, false)
                .previewDisplayName("Bools")
        }.previewLayout(.sizeThatFits)
    }
}
