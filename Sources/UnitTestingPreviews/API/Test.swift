import SwiftUI

public struct Test<Assertions: Assertion>: TestSpec {
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
