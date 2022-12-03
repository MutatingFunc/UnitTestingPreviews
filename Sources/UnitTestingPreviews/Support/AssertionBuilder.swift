import SwiftUI

@resultBuilder
public enum AssertionBuilder {
    public static func buildExpression(_ expression: ()) {
    }
    public static func buildExpression<A: Assertion>(_ expression: A) -> _AssertionResult<A> {
        _AssertionResult(expression)
    }
    public static func buildPartialBlock<V1: Assertion>(first: V1) -> V1 {
        first
    }
    public static func buildPartialBlock<V1: Assertion, V2: Assertion>(accumulated: V1, next: V2) -> _TupleAssertion<V1, V2> {
        _TupleAssertion(accumulated, next)
    }
    public static func buildEither<A: Assertion, B: Assertion>(first component: _AssertionResult<A>) -> _AssertionResult<_AssertIfEitherView<A, B>> {
        _AssertionResult(.a(component.assertion))
    }
    public static func buildEither<A: Assertion, B: Assertion>(second component: _AssertionResult<B>) -> _AssertionResult<_AssertIfEitherView<A, B>> {
        _AssertionResult(.b(component.assertion))
    }
    public static func buildOptional<A: Assertion>(_ component: _AssertionResult<A>?) -> _AssertionResult<some Assertion> {
        _AssertionResult(AssertIfOptionalView(component?.assertion))
    }
    public static func buildArray<A: Assertion>(_ components: [_AssertionResult<A>]) -> _AssertionResult<some Assertion> {
        _AssertionResult(AssertForEachView(assertions: components.map(\.assertion)))
    }
}
