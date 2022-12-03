import SwiftUI

public struct _TupleAssertion<A: Assertion, B: Assertion>: Assertion {
    var a: A, b: B
    init(_ a: A, _ b: B) {
        self.a = a
        self.b = b
    }
    
    public var condition: Bool {
        a.condition && b.condition
    }
    public var description: String { "" }
    public var body: some View {
        a
        b
    }
}

struct _TupleAssertion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            _TupleAssertion(Assert(true, message: "Assert"), Assert(false, message: "Assert"))
                .previewDisplayName("Two previews")
        }.previewLayout(.sizeThatFits)
    }
}
