import SwiftUI

public func AssertForEach<C: Collection>(_ data: C, _ assertions: (C.Element) -> ()) {
    var results: [any Assertion] = []
    Test.$recordClosure.withValue({results.append($0)}) {
        data.forEach(assertions)
    }
    Test.record(AssertForEachView(assertions: results.map(AnyAssertion.init)))
}

@discardableResult
public func AssertForEach<C: Collection, A: Assertion>(_ data: C, @AssertionBuilder _ assertion: (C.Element) -> A) -> some Assertion {
    var results: [any Assertion] = []
    let view = Test.$recordClosure.withValue({results.append($0)}) {
        let r = data.map(assertion)
        results = r
        return AssertForEachView(assertions: r)
    }
    Test.record(AssertForEachView(assertions: results.lazy.map(AnyAssertion.init)))
    return view
}

private struct IdentifiedAssertion<A: Assertion>: Identifiable {
    var id: UUID = UUID()
    var assertion: A
    
    var body: some View {
        assertion
    }
}

private struct AnyAssertion: Assertion {
    var assertion: any Assertion
    var condition: Bool { assertion.condition }
    var description: String { assertion.description }
    var body: some View { AnyView(assertion) }
}

struct AssertForEachView<A: Assertion>: Assertion {
    fileprivate var assertions: [IdentifiedAssertion<A>]
    init(assertions: [A]) {
        self.assertions = assertions.map { assertion in
            IdentifiedAssertion(assertion: assertion)
        }
    }
    
    var condition: Bool {
        assertions.allSatisfy(\.assertion.condition)
    }
    var description: String { "" }
    var body: some View {
        NavigationLink {
            List {
                ForEach(assertions) { assertion in
                    _AssertionResult(assertion.assertion)
                }
            }
            .navigationTitle(condition ? "✓" : "✗")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
        } label: {
            HStack {
                Text(Image(systemName: "diamond.inset.filled"))
                    .accessibilityLabel("Loop with \(assertions.count) iterations")
                    .foregroundColor(.purple)
                Divider()
                if let first = assertions.first?.assertion {
                    first
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("×\(assertions.count)")
                        .foregroundColor(.purple)
                }
            }
        }.disabled(assertions.count == 0)
    }
}

struct _ArrayAssertion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AssertForEachView(assertions: [Assert(true, message: "Assert"), Assert(false, message: "Assert")])
                Text("No selection")
            }
        }.previewLayout(.sizeThatFits)
    }
}
