import SwiftUI

public struct _OptionalAssertion<A: Assertion>: Assertion {
    var value: A?
    init(_ value: A?) {
        self.value = value
    }
    
    public var condition: Bool {
        value?.condition ?? true
    }
    public var description: String { value?.description ?? "" }
    public var body: some View {
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

struct _OptionalAssertion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            _OptionalAssertion(Assert(true, message: "Assert"))
                .previewDisplayName("some")
            _OptionalAssertion(Assert?.none)
                .previewDisplayName("nil")
        }.previewLayout(.sizeThatFits)
    }
}
