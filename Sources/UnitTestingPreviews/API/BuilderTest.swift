import SwiftUI


public struct BuilderTest<Assertions: Assertion>: TestSpec {
    var title: String
    @AssertionBuilder var assertions: () async throws -> Assertions
    @State private var result: Result<Assertions, Error>? = nil
    
    var condition: Bool? {
        if let result {
            return (try? result.get().condition) ?? false
        } else {
            return nil
        }
    }
    
    public init(title: String, @AssertionBuilder assertions: @escaping () async throws -> Assertions) {
        self.title = title
        self.assertions = assertions
    }
    
    public var body: some View {
        Section {
            if let result {
                switch result {
                case .success(let result):
                    result
                case .failure(let error):
                    AssertionResultView(condition: condition) {
                        Text("Error thrown: \(error.localizedDescription)")
                    }
                }
            } else {
                AssertionResultView(condition: nil) {
                    ProgressView()
                        .padding(.trailing, 2)
                    Divider()
                    Text("Running…")
                }.task {
                    result = await Task { try await assertions() }.result
                }
            }
        } header: {
            AssertionResultView(condition: condition) {
                Text(title)
            }
            .onChange(of: condition) { condition in
                if let condition, !condition {
                    print("Test failed: ", title)
                }
            }
        }
    }
}

struct BuilderTest_Tests: TestCase, PreviewProvider {
    static var tests: some TestSpec  {
        BuilderTest(title: "Doofer doof() returns doof") {
            let doofer = Doofer()
            
            let result = doofer.doof()
            
            AssertEqual(result, "doof")
            AssertEqual(result, "doofette")
            AssertGreaterThan(result, "dooa")
            AssertGreaterThanOrEqualTo(result, "doof")
            AssertContains(result, "d")
            AssertNot(AssertContains(result, "a"))
            AssertContains(["doof", "nork"], result)
            if result.count > 3 {
                Assert(true, message: "Is doof")
            } else {
                Assert(false, message: "Is not doof")
            }
            if result.count > 4 {
                Assert(true, message: "Is doof")
            }
            for i in 0..<20 {
                Assert(i%2==0, message: "Is \(i) even")
            }
        }
        BuilderTest(title: "Doofer longDoof() returns doof") {
            let doofer = Doofer()
            
            let result = await doofer.longDoof()
            
            AssertEqual(result, "doof")
        }
    }
}
