import SwiftUI

@discardableResult
public func AssertNot<Other: Assertion>(_ other: @autoclosure () -> Other) -> some Assertion {
    AssertNot {
        other()
    }
}

@discardableResult
public func AssertNot<Other: Assertion>(@AssertionBuilder _ other: () -> _AssertionResult<Other>) -> some Assertion {
    let other = Test.$recordClosure.withValue({ _ in }) {
        other().assertion
    }
    Test.record(AnyAssertNotView(other))
    return AnyAssertNotView(other)
}

private func AnyAssertNotView<Other: Assertion>(_ other: Other) -> some Assertion {
    AssertNotView(other)
}

struct AssertNotView<Other: Assertion>: Assertion {
    var other: Other
    init(_ other: Other) {
        self.other = other
    }
    
    var condition: Bool {
        !other.condition
    }
    var description: String { " ¬ ( " + String(describing: other) + " ) " }
    var body: some View {
        HStack {
            Text("¬")
                .foregroundColor(.purple)
            Text("(")
                .foregroundColor(.purple)
            other
            Text(")")
                .foregroundColor(.purple)
        }
    }
}

struct AssertNot_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssertNot(Assert(true, message: "Assert"))
                .previewDisplayName("Assert")
            AssertNot(AssertEqual(0, 0))
                .previewDisplayName("Equal")
            AssertNot(AssertGreaterThan(0, 0))
                .previewDisplayName("GreaterThan")
            AssertNot(AssertContains([0], 0))
                .previewDisplayName("Contains")
            AssertNot(AssertForEach([0, 1]) { AssertEqual($0, 0) })
                .previewDisplayName("ForEach")
            AssertNot(AssertIf(true) { Assert(true, message: "Assert") })
                .previewDisplayName("If")
        }.previewLayout(.sizeThatFits)
    }
}
