import SwiftUI

public protocol Assertion: View, CustomStringConvertible {
    var condition: Bool {get}
}

extension Never: Assertion {
    public var condition: Bool {
        switch self {}
    }
    public var description: String {
        switch self {}
    }
    var body: EmptyView {
        switch self {}
    }
}
