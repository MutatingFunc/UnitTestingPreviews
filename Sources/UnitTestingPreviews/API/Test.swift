import SwiftUI

public struct Test<Assertions: Assertion>: TestSpec {
    var title: String
    @AssertionBuilder var assertions: () async -> Assertions
    @State private var result: Assertions? = nil
    
    public init(title: String, @AssertionBuilder assertions: @escaping () async -> Assertions) {
        self.title = title
        self.assertions = assertions
    }
    
    public var body: some View {
        Section {
            if let result {
                result
            } else {
                HStack {
                    ProgressView("Running…")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    AssertionResultIcon(condition: nil)
                }.task {
                    result = await assertions()
                }
            }
        } header: {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                AssertionResultIcon(condition: result?.condition)
            }
            .onChange(of: result?.condition) { condition in
                if let condition, !condition {
                    print("Test failed: ", title)
                }
            }
        }
    }
}
