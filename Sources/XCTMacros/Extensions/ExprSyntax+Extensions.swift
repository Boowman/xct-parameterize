//
//  ExprSyntax+Extensions.swift
//
//
//  Created by Lenard Pop on 14/02/2024.
//

import Foundation
import SwiftSyntax

internal extension ExprSyntax {
    func getType() -> String {
        if let member = MemberAccessExprSyntax(self) {
            return member.base?.trimmedDescription ?? ""
        } else if let function = FunctionCallExprSyntax(self) {
            return function.calledExpression.trimmedDescription
        } else if StringLiteralExprSyntax(self) != nil {
            return "String"
        } else if IntegerLiteralExprSyntax(self) != nil {
            return "Int"
        } else if BooleanLiteralExprSyntax(self) != nil {
            return "Bool"
        } else if FloatLiteralExprSyntax(self) != nil {
            return "Float"
        }
        
        return ""
    }
}
