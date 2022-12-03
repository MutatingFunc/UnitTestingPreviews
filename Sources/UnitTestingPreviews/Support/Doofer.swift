import SwiftUI

struct Doofer {
    func doof() -> String {
        "doof"
    }
    
    func longDoof() async -> String {
        try? await Task.sleep(nanoseconds: 3000000000)
        return "doof"
    }
    
    func doof(_ grog: String) -> String {
        grog + "doof"
    }
}
