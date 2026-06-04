    import Foundation
    import SwiftUI

    // Usamos esta clase para encapsular la lógica del resumen económico.
    class FinancySummary: ObservableObject {
        @Published var items: [Record] = [] // Reemplazar con tus registros en el futuro.

        dynamic let totalIncome: Double = 0.0
        dynamic let totalExpense: Double = 0.0

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

            totalIncome = incomeSum // Esto también sirve porque `dynamic`.
            totalExpense = expenseSum
        }

        func updateItems(_ newItems: [Record]) {
            items = newItems
            calculateTotals()
        }
    }
