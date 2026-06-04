//
//  DetailsRecordView.swift
//  FinancyApp
//
//  Created by AlexGI on 03/06/2026.
//

import SwiftUI
import SwiftData

struct DetailsRecordView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    public let item : Record
    
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        ScrollView{
            VStack (alignment: .leading){
                HStack (alignment: .top){
                    Text(item.title)
                        .font(.title)
                }.frame(maxWidth: .infinity)
                
                Text("$ " + String(format: "%.2f", item.amount))
                    .fontWeight(.bold)
                
                Text(item.created, format: .dateTime.month().day().year().hour().minute())
                    .font(.footnote)
            }
            .frame(maxHeight: 120)
            .padding(20)
            .background(.gray.opacity(0.2))
            .cornerRadius(20)
            .padding()
            
            
        }
        .navigationTitle("Detalle de registro")
        .toolbar {
//            ToolbarItem{
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Label("Delete Item", systemImage: "trash")
                }
//            }
        }
        .confirmationDialog("Confirmar borrar", isPresented: $showDeleteConfirmation, titleVisibility: Visibility.visible){
            Button("Borrar", role: .destructive) {
                delete(item: item)
            }
            
            Button("Cancelar", role: .cancel) { }
        }
    }
    
    private func delete(item: Record) {
        modelContext.delete(item)
        dismiss()
    }
}

#Preview {
    DetailsRecordView(item: Record.init(created: Date(), title: "title", amount: 0.00, type: RecordType.income))
}
