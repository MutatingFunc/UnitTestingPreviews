import SwiftUI

public struct Assert: Assertion {
    public var condition: Bool, message: String
    public init(_ condition: Bool, message: String) {
        self.condition = condition
        self.message = message
    }
    
    public var description: String { message + " ? " }
    public var body: some View {
        Text(message) + Text(" ? ").foregroundColor(.purple)
    }
}

struct Assert_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Assert(true, message: "Assert")
                .previewDisplayName("Assert")
            Assert(true, message: "Doof")
                .previewDisplayName("Doof")
        }.previewLayout(.sizeThatFits)
    }
}
