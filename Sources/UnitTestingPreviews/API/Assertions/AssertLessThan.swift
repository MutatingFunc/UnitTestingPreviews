import SwiftUI

public struct AssertLessThan<Value: Comparable>: Assertion {
    public var actual: Value, expectation: Value
    public init(_ actual: Value, _ expectation: Value) {
        self.actual = actual
        self.expectation = expectation
    }
    
    public var condition: Bool {
        actual < expectation
    }
    public var description: String { String(describing: actual) + " < " + String(describing: expectation) }
    public var body: some View {
        Text(String(describing: actual))
        + Text(" < ").foregroundColor(.purple)
        + Text(String(describing: expectation))
    }
}

struct AssertLessThan_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssertLessThan(0, 0)
        }.previewLayout(.sizeThatFits)
    }
}
