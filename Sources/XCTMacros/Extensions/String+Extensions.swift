//
//  String+Extensions.swift
//
//
//  Created by Lenard Pop on 13/02/2024.
//

import Foundation

internal extension String {
    func replaceCharactersWithUnderscores() -> String {
        return String(self
            .replacingOccurrences(of: "\"", with: "")
            .map { ($0.isLetter || $0.isNumber || $0 == "_" ) ? $0 : "_" })
    }
    
    func singleUnderscore() -> String {
        var result = self
        
        while let range = result.range(of: "__") {
            result.replaceSubrange(range, with: "_")
        }
        
        return result
    }
    
    func getValueAfterColon() -> String {       
        if self.contains("URL") {
            
            let request = self.replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .components(separatedBy: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            
            return extractDomain(from: request)
                .joined(separator: "_")
        }
        
        return self
    }
    
    private func extractDomain(from strings: [String]) -> [String] {
        var domains: [String] = []
        
        for string in strings {
          guard let startIndex = string.firstIndex(of: ".") else {
            domains.append("Invalid URL")
            continue
          }
            
          let endIndex = string.lastIndex(of: "/") ?? string.endIndex
          
          let nextIndex = string.index(after: startIndex)
          let domain = String(string[nextIndex..<endIndex])
          
          domains.append(domain.replacingOccurrences(of: "www.", with: ""))
        }
        
        return domains
    }
    
    func removeTrailingUnderscores() -> String {
        var result = self
        
        while result.last == "_" {
            result.removeLast()
        }
        
        return result
    }
    
    func removeLeadingUnderscores() -> String {
        var result = self
        
        while result.first == "_" {
            result.removeFirst()
        }
        
        return result
    }
}
