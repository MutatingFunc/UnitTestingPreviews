import SwiftUI

public protocol TestCase: PreviewProvider {
    associatedtype Tests: View
    @TestBuilder
    static var tests: Tests {get}
}
public extension TestCase {
    static var previews: some View {
        NavigationSplitView {
            List {
                tests
            }
        } detail: {
            Text("No selection")
        }
    }
}

struct TestCase_Previews_Tests: TestCase, PreviewProvider {
    private struct Doofer {
        func doof() -> String {
            "doof"
        }
        
        func longDoof() async -> String {
            try? await Task.sleep(for: .seconds(1))
            return "doof"
        }
        
        func doof(_ grog: String) -> String {
            grog + "doof"
        }
    }

    static var tests: some View  {
        Test(title: "Doofer doof() returns doof") {
            let doofer = Doofer()
            
            let result = doofer.doof()
            
            AssertEqual(result, "doof")
            AssertEqual(result, "doofette")
            AssertGreaterThan(result, "dooa")
            AssertGreaterThanOrEqualTo(result, "doof")
            AssertContains(result, "d")
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
        Test(title: "Doofer longDoof() returns doof") {
            let doofer = Doofer()
            
            let result = await doofer.longDoof()
            
            AssertEqual(result, "doof")
        }
    }
}