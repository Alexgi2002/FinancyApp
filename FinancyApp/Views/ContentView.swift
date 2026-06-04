//
//  ContentView.swift
//  FinancyApp
//
//  Created by AlexGI on 03/06/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Record]
    
    @State private var viewModel: FinancySummary?
    
    @State private var showAddRecord : Bool = false
    @State private var title : String = ""
    @State private var amount : String = ""
    @State private var date : Date = Date()
    @State private var errorMsg : String = ""
    @State private var selectedType : RecordType = RecordType.income
    
    
        
    var body: some View {
        NavigationStack {
            
            if let vm = viewModel {
                    
                List {
                    
                    Text("$ " + String(format: "%.2f", vm.totalIncome - vm.totalExpense))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .listRowSeparator(.hidden)
                    
                    HStack(alignment: .center){
                        VStack(alignment: .leading){
                            Text("Tus ingresos")
                            Spacer(minLength: 75)
                            Text("$ " + String(format: "%.2f", vm.totalIncome))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .fontWeight(.bold)
                                .font(Font.title)
                                .lineLimit(1)
                        }
                        .padding()
                        .background(.green.opacity(0.5))
                        .cornerRadius(12)
//                        .padding(4)
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            Text("Tus gastos")
                            Spacer(minLength: 75)
                            Text("$ " + String(format: "%.2f", vm.totalExpense))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .fontWeight(.bold)
                                .font(Font.title)
                                .lineLimit(1)
                        }
                        .padding()
                        .background(.red.opacity(0.5))
                        .cornerRadius(12)
//                        .padding(4)
                    }
                    Text("Tus actividades")
                        .fontDesign(.monospaced)
                        .padding(.top, 20)
                        .listRowSeparator(.hidden)
                    
                    ForEach(vm.items) { item in
                        
                        NavigationLink {
                            DetailsRecordView(item: item)
                        } label: {
                            HStack{
                                item.type == RecordType.income ?
                                Image(systemName: "arrow.up")
                                    .padding()
                                    .background(.green.opacity(0.5))
                                    .cornerRadius(50)
                                : Image(systemName: "arrow.down")
                                    .padding()
                                    .background(.red.opacity(0.5))
                                    .cornerRadius(50)
                                VStack(alignment: .leading){
                                    Text(item.title)
                                        .lineLimit(1)
                                    Text(item.created, format: .dateTime.month().day().year().hour().minute())
                                        .font(.footnote)
                                        .lineLimit(1)
                                }
                                .padding(.horizontal, 10)
                                Spacer()
                                Text("$ " + String(format: "%.2f", item.amount))
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                            }
                            
                        }
                    }
                    .onDelete(perform: vm.deleteItems)
                    .padding(.bottom, 20)
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("FinancyApp")
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showAddRecord = true
                        }) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            else {
                ProgressView()
            }
        }.sheet(isPresented: $showAddRecord){
            if let vm = viewModel {
                
                
                ScrollView{
                    VStack (alignment: .leading){
                        Spacer(minLength: 12)
                        Text("Nuevo registro")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                            .font(Font.title)
                            .lineLimit(1)
                            .padding(.bottom, 30)
                        
                        
                        TextField("Título", text: $title)
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(16)
                            .padding()
                        
                        TextField("Monto", text: $amount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(16)
                            .padding()
                        
                        DatePicker("Fecha", selection: $date, displayedComponents: .date)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                        
                        Text("Tipo de transacción")
                            .padding(.horizontal, 20)
                        
                        Picker("", selection: $selectedType) {
                            Text("Ingreso").tag(RecordType.income)
                            Text("Gasto").tag(RecordType.expense)
                        }.pickerStyle(.segmented)
                            .padding(.horizontal, 20)
                        
                        
                        Spacer(minLength: 50)
                        
                        HStack{
                            Button("Cancelar") {
                                showAddRecord = false
                            }
                            .buttonStyle(.bordered)
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Button("Aceptar") {
                                guard !title.isEmpty && !amount.isEmpty else {
                                    errorMsg = "Todos los campos son requeridos"
                                    return
                                }
                                
                                let x = Double(amount)
                                
                                if let amountFinal = x {
                                    
                                    guard amountFinal > 0 else {
                                        errorMsg = "Monto no válido"
                                        return
                                    }
                                    
                                    vm.addItem(title: title, amount: amountFinal, date: date, type: selectedType)
                                    showAddRecord = false
                                    errorMsg = ""
                                    title = ""
                                    amount = ""
                                }
                                else{
                                    errorMsg = "Monto no válido"
                                    //                                return
                                }
                                
                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity)
                        }.padding(.bottom, 50)
                        
                        if(!errorMsg.isEmpty){
                            Text(errorMsg)
                                .font(Font.body.monospacedDigit())
                                .foregroundStyle(.red)
                        }
                        
                    }
                }
            }
            else {
                ProgressView()
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = FinancySummary(modelContext: modelContext.self)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Record.self, inMemory: false)
}
