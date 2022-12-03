import SwiftUI

public struct Test: TestSpec {
    @TaskLocal
    static var recordClosure: (any Assertion) -> () = {_ in }
    @discardableResult
    static func record<A: Assertion>(_ result: A) -> A {
        recordClosure(result)
        return result
    }
    
    var title: String
    var assertions: () async throws -> ()
    @State private var results: [IdentifiedAssertion] = []
    @State private var didPass: Bool?
    
    public init(title: String, assertions: @escaping () async throws -> ()) {
        self.title = title
        self.assertions = assertions
    }
    
    public var body: some View {
        Section {
            ForEach(results) { result in
                AssertionResultView(condition: result.assertion.condition) {
                    result.body
                }
            }
            if didPass == nil {
                AssertionResultView(condition: nil) {
                    ProgressView()
                        .padding(.trailing, 2)
                    Divider()
                    Text("Running…")
                }
                .task {
                    await Self.$recordClosure.withValue({ results.append(.init(assertion: $0)) }) {
                        try? await assertions()
                        didPass = results.allSatisfy { $0.assertion.condition }
                        if didPass == false {
                            print("Test failed: ", title)
                        }
                    }
                    
                }
            }
        } header: {
            AssertionResultView(condition: didPass) {
                Text(title)
            }
        }
    }
}

private struct IdentifiedAssertion: Identifiable, View {
    var id: UUID = UUID()
    var assertion: any Assertion
    
    // Required to unbox `any Assertion`
    var body: some View { AnyView(assertion) }
}

struct Test_Tests: TestCase, PreviewProvider {
    static var tests: some TestSpec  {
        Test(title: "Doofer doof() returns doof") {
            let doofer = Doofer()
            
            let result = doofer.doof()
            
            AssertEqual(result, "doof")
            AssertEqual(result, "doofette")
            AssertGreaterThan(result, "dooa")
            AssertGreaterThanOrEqualTo(result, "doof")
            AssertContains(result, "d")
            AssertNot(AssertContains(result, "a"))
            AssertContains(["doof", "nork"], result)
            AssertIf(result.count > 3) {
                Assert(true, message: "Is doof")
            } else: {
                Assert(false, message: "Is not doof")
            }
            AssertIf(result.count > 4) {
                Assert(true, message: "Is doof")
            }
            AssertForEach(0..<20) { i in
                Assert(i%2==0, message: "Is \(i) even")
            }
        }
        Test(title: "Doofer longDoof() returns doof") {
            let doofer = Doofer()
            
            let result = await doofer.longDoof()
            
            AssertEqual(result, "doof")
        }
    }
}
