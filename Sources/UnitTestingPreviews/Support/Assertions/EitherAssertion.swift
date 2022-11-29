import SwiftUI

public enum _EitherAssertion<A: Assertion, B: Assertion>: Assertion {
    case a(A)
    case b(B)
    
    public var condition: Bool {
        switch self {
        case .a(let a): return a.condition
        case .b(let b): return b.condition
        }
    }
    public var description: String {
        switch self {
        case .a(let a): return a.description
        case .b(let b): return b.description
        }
    }
    public var body: some View {
        HStack {
            EitherAssertIcon(condition: condition)
                .foregroundColor(.purple)
            Divider()
            switch self {
            case .a(let a): a
            case .b(let b): b
            }
        }
    }
}

struct _EitherAssertion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            _EitherAssertion<Assert, Assert>.a(Assert(true, message: "Assert"))
                .previewDisplayName("a")
            _EitherAssertion<Assert, Assert>.b(Assert(true, message: "Assert"))
                .previewDisplayName("b")
        }.previewLayout(.sizeThatFits)
    }
}
