//
//  ContentView.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 16.06.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var vm: ViewModel
    
    @State private var isValid: Bool = true
    @State private var value = "-100"
    @State private var isError: Bool = false
    @State private var selectedDate: Date = .now
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                leftoverText
                debtText
                
                Spacer()
                    .frame(height: 80)
                
                textField
                datePicker
                
                HStack(alignment: .bottom, spacing: 64) {
                    minus
                    plus
                }
                .padding(.vertical, 16)
                
                Divider()
                    .background(.primary)
                    .padding(.bottom, 16)
                
                if vm.transactions.isEmpty || isError {
                    Text(isError ? "Виникла помилка" : "Транзакції відсутні")
                        .modifier(.leadingText)
                } else {
                    transactionCells
                }
                
            }
        }
        .contentMargins(.bottom, 68, for: .scrollContent)
        .overlay(alignment: .bottom) {
            if isValid {
                transactionBtn
            }
        }
        .onChange(of: value, { _, newValue in
            withAnimation {
                isValid = newValue.int != 0 && !newValue.isEmpty
            }
        })
        .onTapGesture {
            isFocused = false
        }
        .task {
            loadTransactions()
        }
    }
}

private extension ContentView {
    var leftoverText: some View {
        Text("Залишок від М.: \(vm.leftover) USDT")
            .modifier(.leadingText)
            .padding(.bottom, 4)
            .padding(.top, 32)
    }
    
    var debtText: some View {
        Text("Борг: \(vm.totalDebt) USDT")
            .modifier(.leadingText)
    }
    
    var textField: some View {
        TextField("", text: $value)
            .frame(width: 100, height: 50)
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
            .font(.title2.weight(.bold).monospaced())
            .keyboardType(.numbersAndPunctuation)
            .focused($isFocused)
            .modifier(.boxPrimaryShadow)
    }
    
    var datePicker: some View {
        DatePicker("",
                   selection: $selectedDate,
                   in: ...Date.now,
                   displayedComponents: .date)
            .datePickerStyle(.compact)
            .labelsHidden()
            .padding(.top, 16)
    }
    
    var minus: some View {
        Button {
            subtract()
        } label: {
            Image(systemName: "minus")
                .resizable()
                .scaledToFit()
                .padding()
        }
        .frame(width: 60, height: 60)
        .modifier(.boxPrimaryShadow)
        .tint(.black)
    }
    
    var plus: some View {
        Button {
            add()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .padding()
        }
        .frame(width: 60, height: 60)
        .modifier(.boxSecondaryShadow)
        .tint(.white)
    }
    
    var transactionCells: some View {
        ForEach(vm.transactions) { item in
            TransactionCellView(transaction: item)
                .contextMenu {
                    Button(role: .destructive) {
                        delete(transaction: item)
                    } label: {
                        Label("Видалити", systemImage: "trash")
                    }
                }
                .transition(.asymmetric(insertion: .push(from: .top), removal: .identity))
        }
    }
    
    var transactionBtn: some View {
        Button {
            addTransaction()
        } label: {
            Text("Додати транзакцію")
                .frame(maxWidth: .infinity, maxHeight: 44)
                .font(.system(size: 18, weight: .medium).monospaced())
        }
        .modifier(.boxPrimaryShadow)
        .padding(.horizontal, 24)
        .padding(.bottom, 8)
        .tint(.black)
        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .offset(y: 86)))
    }
}

private extension ContentView {
    func add() {
        guard let int = value.int else { return }
        value = (int + 100).string
    }
    
    func subtract() {
        guard let int = value.int else { return }
        value = (int - 100).string
    }
    
    func delete(transaction: Transaction) {
        withAnimation {
            do {
                try vm.remove(transaction: transaction)
            } catch {
                isError = true
            }
        }
    }
    
    func addTransaction() {
        withAnimation {
            do {
                try vm.add(value: value, date: selectedDate)
            } catch {
                isError = true
            }
        }
    }
    
    func loadTransactions() {
        do {
            try vm.loadTransactions()
        } catch {
            isError = true
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
