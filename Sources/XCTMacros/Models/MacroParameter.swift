//
//  MacroParameter.swift
//
//
//  Created by Lenard Pop on 09/02/2024.
//

import Foundation

internal struct MacroParameter: ParameterProtocol {
    internal var type: Any
    internal var name: String?
    internal var value: String?
    
    init(type: Any, value: String) {
        self.type = type
        self.value = value
    }
    
    func getType() -> Any {
        return type
    }
    
    func getName() -> String {
        guard let name = name else {
            return ""
        }
        
        return name
    }
    
    func getValue(escapeString: Bool = false) -> String {
        guard let value = value else {
            return ""
        }

        if escapeString {
            return value
        }
        
        return value.replacingOccurrences(of: "\"\"", with: "")
    }
}
