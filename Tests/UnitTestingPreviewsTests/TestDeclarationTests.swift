import SwiftUI
import UnitTestingPreviews


struct TestCase_Previews_Tests: TestCase, PreviewProvider {
    private struct Doofer {
        func doof() -> String {
            "doof"
        }
        
        func longDoof() async -> String {
            try? await Task.sleep(nanoseconds: 1000000000)
            return "doof"
        }
        
        func doof(_ grog: String) -> String {
            grog + "doof"
        }
    }

    static var tests: some TestSpec  {
        let _ = "doof"
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
            AssertForEach(0..<20) { i in
                Assert(i%2==0, message: "Is \(i) even")
            }
            AssertNot(
                AssertIf(result.count > 2) {
                    Assert(true, message: "Is doof")
                }
            )
            AssertNot {
                AssertForEach(0..<20) { i in
                    Assert(i%2==0, message: "Is \(i) even")
                }
            }
        }
        BuilderTest(title: "Doofer longDoof() returns doof") {
            let doofer = Doofer()
            
            let result = await doofer.longDoof()
            
            AssertEqual(result, "doof")
        }
    }
}
