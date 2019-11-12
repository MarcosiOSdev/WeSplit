//
//  ContentView.swift
//  WeSplit
//
//  Created by Marcos Felipe Souza on 12/11/19.
//  Copyright © 2019 Marcos Felipe Souza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmout = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //calculate the total per person here
        let numberOfPeopleInt = Int(numberOfPeople) ?? 0
        let peopleCount = Double( numberOfPeopleInt + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmountDecimal) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var checkAmountDecimal: String {
        return checkAmout.replacingOccurrences(of: ",", with: ".")
    }
    
    var amountTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmountDecimal) ?? 0
        let tipOrderAmount = orderAmount * (tipSelection / 100)
        return orderAmount + tipOrderAmount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmout)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave ?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount total")) {
                    Text("$\(amountTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
        }.navigationBarTitle("We Split")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
