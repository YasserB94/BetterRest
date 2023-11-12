//
//  MainView.swift
//  BetterRest
//
//  Created by Yasser Bal on 12/11/2023.
//

import SwiftUI

struct MainView: View {
    @State private var sleepAmount = 0.0
    @State private var wakeUp = Date.now

    
    var body: some View {
        NavigationStack{
            VStack{
                DatePicker("Please enter a date", selection: $wakeUp)
                    .pickerStyle(.wheel)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)

            }
            .padding(.horizontal,30)
            .navigationTitle("BetterRest")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
