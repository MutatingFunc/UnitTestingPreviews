import SwiftUI

@discardableResult
public func AssertGreaterThanOrEqualTo<Value: Comparable>(_ actual: Value, _ expectation: Value) -> some Assertion {
    Test.record(AssertGreaterThanOrEqualToView(actual, expectation))
}

struct AssertGreaterThanOrEqualToView<Value: Comparable>: Assertion {
    var actual: Value, expectation: Value
    init(_ actual: Value, _ expectation: Value) {
        self.actual = actual
        self.expectation = expectation
    }
    
    var condition: Bool {
        actual >= expectation
    }
    var description: String { String(describing: actual) + " ≥ " + String(describing: expectation) }
    var body: some View {
        Text(String(describing: actual))
        + Text(" ≥ ").foregroundColor(.purple)
        + Text(String(describing: expectation))
    }
}

struct AssertGreaterThanOrEqualTo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssertGreaterThanOrEqualTo(0, 0)
        }.previewLayout(.sizeThatFits)
    }
}
