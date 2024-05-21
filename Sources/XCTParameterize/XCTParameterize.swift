// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces a copy of the original method but it adds the extra parameters as a local variable
/// the main purpose of the macro is to parameterize UnitTest methods. For example,
///
///     @InlineData("XCTParameterize")
///     func testingMethod(value: String)
///
@attached(peer, names: arbitrary)
public macro InlineData(_ value: Any...) = #externalMacro(module: "XCTMacros", type: "InlineDataMacro")

/// A macro that produces a copy of the original method but it adds the extra parameters as a local variable
/// the main purpose of the macro is to parameterize UnitTest methods. For example,
///
///     @InlineData("XCTParameterize")
///     func testingMethod(value: String, label: "URLCheck")
///
@attached(peer, names: arbitrary)
public macro InlineData(_ value: Any..., label: String) = #externalMacro(module: "XCTMacros", type: "InlineDataMacro")
