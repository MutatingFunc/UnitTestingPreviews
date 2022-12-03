import SwiftUI

@discardableResult
public func AssertIf<A: Assertion>(_ condition: Bool, @AssertionBuilder _ ifTrue: () -> A) -> some Assertion {
    if condition {
        let ifTrue = Test.$recordClosure.withValue({_ in}, operation: ifTrue)
        return Test.record(AssertIfOptionalView<A>(ifTrue))
    } else {
        return Test.record(AssertIfOptionalView<A>(nil))
    }
}

struct AssertIfOptionalView<A: Assertion>: Assertion {
    var value: A?
    init(_ value: A?) {
        self.value = value
    }
    
    var condition: Bool {
        value?.condition ?? true
    }
    var description: String { value?.description ?? "" }
    var body: some View {
        HStack {
            EitherAssertIcon(condition: value != nil)
                .foregroundColor(value != nil ? .purple : .gray)
            Divider()
            if let value {
                value
            }
        }
    }
}

struct AssertIfOptional_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssertIfOptionalView(AssertView(true, message: "Assert"))
                .previewDisplayName("some")
            AssertIfOptionalView(AssertView?.none)
                .previewDisplayName("nil")
        }.previewLayout(.sizeThatFits)
    }
}
