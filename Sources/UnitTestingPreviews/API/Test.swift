import SwiftUI

public struct Test<Assertions: Assertion>: View {
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
                LabeledContent {
                    Divider()
                    _AssertionResultIcon(condition: nil)
                } label: {
                    ProgressView("Running…")
                }.task {
                    result = await assertions()
                }
            }
        } header: {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                _AssertionResultIcon(condition: result?.condition)
            }
        }.onAppear {
            if let result, !result.condition, !result.description.isEmpty {
                print(result.description)
            }
        }
    }
}
