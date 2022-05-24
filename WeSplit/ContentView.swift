//
//  ContentView.swift
//  WeSplit
//
//  Created by Vladislav Gorovenko on 21.05.2022.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    var currency: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: "USD")
    }
    var totalPerPerson: Double {
        let amountOfPeople = Double(numberOfPeople + 2)
        let tip = Double(tipPercentage)/100
        return ((checkAmount+checkAmount*tip)/amountOfPeople)
    }
    var total: Double {
        let tip = Double(tipPercentage)/100
        return checkAmount+checkAmount*tip
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              format: currency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people",
                           selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    HStack(spacing: 0) {
                        Text("Each person shall pay - ")
                        Text(totalPerPerson, format: currency)
                    }
                } header: {
                    Text("Amount per person")
                }
                Section {
                    HStack(spacing: 0) {
                        Text("In total - ")
                        Text(totalPerPerson, format: currency)
                        Text(" shall be paid.")
                    }
                } header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        amountIsFocused = false
                    } label: {
                        Text("DONE")
                    }

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
