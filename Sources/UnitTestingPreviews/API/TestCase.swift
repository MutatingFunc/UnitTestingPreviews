import SwiftUI

public protocol TestCase: PreviewProvider {
    associatedtype Tests: TestSpec
    @TestBuilder
    static var tests: Tests {get}
}
public extension TestCase {
    static var previews: some View {
        NavigationView {
            List {
                tests
            }
            Text("No selection")
        }
    }
}

struct TestCase_Previews_Tests: TestCase, PreviewProvider {
    static var tests: some TestSpec  {
        Test_Tests.tests
        BuilderTest_Tests.tests
    }
}
