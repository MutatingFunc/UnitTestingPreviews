import SwiftUI

public protocol Assertion: View, CustomStringConvertible {
    var condition: Bool {get}
}
