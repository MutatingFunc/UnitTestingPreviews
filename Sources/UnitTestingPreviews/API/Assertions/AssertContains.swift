import SwiftUI

@discardableResult
public func AssertContains<Value>(_ actual: Value, _ expectation: Value.Element) -> some Assertion where Value: Collection, Value.Element: Equatable {
    Test.record(AssertContainsView(actual, expectation))
}

struct AssertContainsView<Value>: Assertion where Value: Collection, Value.Element: Equatable {
    var actual: Value, expectation: Value.Element
    init(_ actual: Value, _ expectation: Value.Element) {
        self.actual = actual
        self.expectation = expectation
    }
    
    var condition: Bool {
        actual.contains(expectation)
    }
    var description: String { String(describing: actual) + " ∋ " + String(describing: expectation) }
    var body: some View {
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
