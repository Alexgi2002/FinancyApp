import Foundation
import SwiftData

@MainActor // Crucial para que los cambios toquen la UI en el hilo correcto
@Observable
class FinancySummary {
    var items: [Record] = []
    
    var totalIncome: Double = 0.0
    var totalExpense: Double = 0.0
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchCandidates()
    }
    
    func calculateTotals() {
        var incomeSum: Double = 0
        var expenseSum: Double = 0
        
        items.forEach { item in
            if item.type == .income {
                incomeSum += item.amount
            } else {
                expenseSum += item.amount
            }
        }
        
        totalIncome = incomeSum
        totalExpense = expenseSum
    }
    
//    func updateItems(_ newItems: [Record]) {
//        items = newItems
//        calculateTotals()
//    }
    
    
    func fetchCandidates() {
        // Un FetchDescriptor es tu sentencia "SELECT * FROM UserItem WHERE..."
        let descriptor = FetchDescriptor<Record>(
//            predicate: #Predicate<Record> { $0.isMatch == false },
            sortBy: [SortDescriptor(\.created, order: .reverse)]
        )
        
        do {
            self.items = try modelContext.fetch(descriptor)
            calculateTotals()
        } catch {
            print("Error al traer candidatos: \(error)")
        }
    }
    
    
    func addItem(title: String, amount: Double, date: Date, type: RecordType) {
        let newItem = Record(created: date, title: title, amount: amount, type: type)
        modelContext.insert(newItem)
        fetchCandidates()
    }

    func deleteItems(offsets: IndexSet) {
//        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
//        }
        
        try? modelContext.save()
        fetchCandidates()
    }
}
