# UnitTestingPreviews

A previews-based unit testing framework suitable for Swift Playgrounds Apps.

Usage:

```

struct Doofer {
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

struct Doofer_Tests: TestCase, PreviewProvider {
    static var tests: some View  {
        Test(title: "Doofer doof() returns doof") {
            let doofer = Doofer()
            
            let result = doofer.doof()
            
            AssertEqual(result, "doof")
            AssertEqual(result, "doofette")
            AssertGreaterThan(result, "dooa")
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

```
