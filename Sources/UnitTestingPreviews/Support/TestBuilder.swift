import SwiftUI

@resultBuilder
public enum TestBuilder {
    public static func buildPartialBlock<Test: TestSpec>(first expression: Test) -> Test {
        expression
    }
    public static func buildPartialBlock<Tests: View, Test: TestSpec>(accumulated: Tests, next: Test) -> _TupleTest<(Tests, Test)> {
        _TupleTest((accumulated, next))
    }
}

public protocol TestSpec: View {}
public struct _TupleTest<T>: TestSpec {
    var tuple: T
    init(_ tuple: T) {
        self.tuple = tuple
    }
    public var body: some View {
        TupleView(tuple)
    }
}
