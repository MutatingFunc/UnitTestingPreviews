import SwiftUI

public struct AssertContains<Value>: Assertion where Value: Collection, Value.Element: Equatable {
    public var actual: Value, expectation: Value.Element
    public init(_ actual: Value, _ expectation: Value.Element) {
        self.actual = actual
        self.expectation = expectation
    }
    
    public var condition: Bool {
        actual.contains(expectation)
    }
    public var description: String { String(describing: actual) + " ∋ " + String(describing: expectation) }
    public var body: some View {
        Text(String(describing: actual))
        + Text(" ∋ ").foregroundColor(.purple)
        + Text(String(describing: expectation))
    }
}

struct AssertContains_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssertContains(["Doof", "Nork"], "Doof")
                .previewDisplayName("Two")
            AssertContains(["Doof"], "Doof")
                .previewDisplayName("One")
            AssertContains([], "Doof")
                .previewDisplayName("None")
        }.previewLayout(.sizeThatFits)
    }
}
