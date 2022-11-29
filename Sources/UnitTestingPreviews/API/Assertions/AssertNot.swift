import SwiftUI

public struct AssertNot<Other: Assertion>: Assertion {
    public var other: Other
    public init(_ other: Other) {
        self.other = other
    }
    
    public var condition: Bool {
        !other.condition
    }
    public var description: String { " ¬ ( " + String(describing: other) + " ) " }
    public var body: some View {
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
        }.previewLayout(.sizeThatFits)
    }
}
