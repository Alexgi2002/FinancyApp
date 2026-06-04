//
//  Item.swift
//  FinancyApp
//
//  Created by AlexGI on 03/06/2026.
//

import Foundation
import SwiftData

@Model
final class Record: Identifiable {
    var id: UUID
    var created: Date
    var title: String
    var amount: Double
    var type: RecordType
    
    init(created: Date, title: String, amount: Double, type: RecordType) {
        self.id = .init()
        self.created = created
        self.title = title
        self.amount = amount
        self.type = type
    }
}

enum RecordType: String, Codable {
    case income
    case expense
}
