//
//  Quote.swift
//  Quote Day
//
//  Created by Magesh K on 22/06/25.
//

import Foundation

struct Quote: Codable, Identifiable {
    var id: UUID { UUID() } // Since ZenQuotes has no unique ID
    
    let q: String    // Quote content
    let a: String    // Author
}
