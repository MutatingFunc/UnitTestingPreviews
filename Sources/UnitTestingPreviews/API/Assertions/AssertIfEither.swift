import SwiftUI

@discardableResult
public func AssertIf<A1: Assertion, A2: Assertion>(_ condition: Bool, _ ifTrue: () -> A1, else ifFalse: () -> A2) -> some Assertion {
    if condition {
        let ifTrue = Test.$recordClosure.withValue({_ in}, operation: ifTrue)
        return Test.record(_AssertIfEitherView<A1, A2>.a(ifTrue))
    } else {
        let ifFalse = Test.$recordClosure.withValue({_ in}, operation: ifFalse)
        return Test.record(_AssertIfEitherView<A1, A2>.b(ifFalse))
    }
}

public enum _AssertIfEitherView<A: Assertion, B: Assertion>: Assertion {
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

struct AssertIfEither_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            _AssertIfEitherView<AssertView, AssertView>.a(.init(true, message: "Assert"))
                .previewDisplayName("a")
            _AssertIfEitherView<AssertView, AssertView>.b(.init(true, message: "Assert"))
                .previewDisplayName("b")
        }.previewLayout(.sizeThatFits)
    }
}
