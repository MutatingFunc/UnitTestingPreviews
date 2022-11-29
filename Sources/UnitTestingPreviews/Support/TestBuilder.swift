import SwiftUI

@resultBuilder
public enum TestBuilder {
    public static func buildPartialBlock<Assertions: View>(first expression: Test<Assertions>) -> Test<Assertions> {
        expression
    }
    public static func buildPartialBlock<Assertions1: View, Assertions2: View>(accumulated: Assertions1, next: Test<Assertions2>) -> TupleView<(Assertions1, Test<Assertions2>)> {
        TupleView((accumulated, next))
    }
}

