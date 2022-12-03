import SwiftUI

@resultBuilder
public enum TestBuilder {
    public static func buildPartialBlock<Assertions: Assertion>(first expression: Test<Assertions>) -> Test<Assertions> {
        expression
    }
    public static func buildPartialBlock<Tests: View, Assertions: Assertion>(accumulated: Tests, next: Test<Assertions>) -> _TupleTest<(Tests, Test<Assertions>)> {
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
