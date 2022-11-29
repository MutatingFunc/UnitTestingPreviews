import SwiftUI

public struct _ArrayAssertion<A: Assertion>: Assertion {
    var assertions: [A]
    
    public var condition: Bool {
        assertions.allSatisfy(\.condition)
    }
    public var description: String { "" }
    public var body: some View {
        NavigationLink {
            List {
                ForEach(0..<assertions.count) { assertionIndex in
                    _AssertionResult(assertion: assertions[assertionIndex])
                }
            }
            .navigationTitle(condition ? "✓" : "✗")
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text(Image(systemName: "diamond.inset.filled"))
                .accessibilityLabel("Loop with \(assertions.count) iterations")
                .foregroundColor(.purple)
            Divider()
            if let first = assertions.first {
                first
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("×\(assertions.count)")
                    .foregroundColor(.purple)
            }
        }.disabled(assertions.count == 0)
    }
}

struct _ArrayAssertion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationSplitView {
                _ArrayAssertion(assertions: [Assert(true, message: "Assert"), Assert(false, message: "Assert")])
            } detail: {
                Text("No selection")
            }
        }.previewLayout(.sizeThatFits)
    }
}
