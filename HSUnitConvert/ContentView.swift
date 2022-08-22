//
//  ContentView.swift
//  HSUnitConvert
//
//  Created by Ian Bailey on 21/8/2022.
//

import SwiftUI


struct ContentView: View {
    @State private var fromDistance = 0.0
    @State private var fromUnits = "meters"
    @State private var toUnits = "kilometers"
    @FocusState private var distanceIsFocused: Bool

    let distanceUnits = ["meters", "kilometers", "yards", "miles"]
    
    var toDistance: Double {
        var meters = 0.0
        // convert the from distance to meters
        switch fromUnits {
            case "meters": meters = fromDistance
            case "kilometers": meters = fromDistance*1000
            case "yards": meters = fromDistance*0.9144
            case "miles": meters = fromDistance*1609.34
            default: assert(false)
        }
        // convert the meters to the from distance
        switch toUnits {
            case "meters": return meters
            case "kilometers": return meters/1000
            case "yards": return meters/0.9144
            case "miles": return meters/1609.34
            default : assert(false)
        }
        return 0.0
    }

    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Distance", value: $fromDistance, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($distanceIsFocused)
                    Picker("Units", selection: $fromUnits) {
                        ForEach(distanceUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                header: {
                    Text("Distance")
                }
                
                Section {
                    if toDistance < 9.9 {
                        Text("\(toDistance, specifier: "%.4f")")
                    } else if toDistance > 999 {
                        Text("\(toDistance, specifier: "%.0f")")
                    } else {
                        Text("\(toDistance, specifier: "%.2f")")
                    }

                    Picker("Units", selection: $toUnits) {
                        ForEach(distanceUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                header: {
                    Text("Converted Distance")
                }
                
            }
            .navigationTitle("Distance Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        distanceIsFocused = false
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
