//
//  MainView.swift
//  BetterRest
//
//  Created by Yasser Bal on 12/11/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var vm = MainViewModel()

    
    var body: some View {
        NavigationStack{
            VStack{
                Text(
                    "When would you like to wake up?"
                )
                    .font(.headline)
                DatePicker(
                    "Please enter a time",
                    selection: $vm.wakeDate,
                    displayedComponents: .hourAndMinute
                )
                    .labelsHidden()
                Text("Howmany hours would you like to sleep?")
                Stepper(
                    "\(vm.amountOfSleepInHours.formatted())",
                    value: $vm.amountOfSleepInHours,
                    in:vm.MIN_HOURS_SLEEP...vm.MAX_HOURS_SLEEP,
                    step:0.25
                )
                Text("Cups of coffee drank per day")
                
                Stepper(
                    "\(vm.cupsOfCoffeeDrank) cup(s)",
                    value:$vm.cupsOfCoffeeDrank,
                    in:vm.MIN_CUPS_COFFEE...vm.MAX_CUPS_COFFEE
                )
            }
            .padding(.horizontal,30)
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Resolve",action: calculateBedtime)
            }
        }
    }
    func calculateBedtime(){
        print("World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
