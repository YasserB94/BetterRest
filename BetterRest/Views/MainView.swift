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
                if vm.errorFeedback != nil {
                 errorFeedback
                }
                Form{
                    VStack(alignment: .leading,spacing:10){
                        Text(
                            "When would you like to wake up?"
                        )
                        .font(.headline)
                        DatePicker(
                            "Please enter a time",
                            selection: $vm.inputWakeTime,
                            displayedComponents: .hourAndMinute
                        )
                        .labelsHidden()
                    }
                    VStack(alignment: .leading,spacing:10){
                        Text("Desired hours of sleep")
                            .font(.headline)
                        Stepper(
                            "\(vm.inputHoursOfSleep.formatted())",
                            value: $vm.inputHoursOfSleep,
                            in:MainViewModel.MIN_HOURS_SLEEP...MainViewModel.MAX_HOURS_SLEEP,
                            step:0.25
                        )
                    }
                    VStack(alignment: .leading,spacing:10){
                        Text("Coffee intake")
                            .font(.headline)
                        Stepper(
                            "^[\(vm.inputCupsOfCoffeeDrank) cup](inflect:true)",
                            value:$vm.inputCupsOfCoffeeDrank,
                            in:MainViewModel.MIN_CUPS_COFFEE...MainViewModel.MAX_CUPS_COFFEE
                        )
                    }
                }
                predition
            }
            .navigationTitle("BetterRest")
        }
    }
    
    var predition:some View{
        VStack(alignment: .center){
            if let time = vm.predictedSleepTime {
                VStack{
                    Text("Your ideal bedtime is:")
                    Text("\(time.formatted(date:.omitted,time:.shortened))").font(.largeTitle)
                }
                .padding(20)
                .background()
                .cornerRadius(10)
                .shadow(radius: 1)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight:.infinity
        )
    }
    
    var errorFeedback:some View{
            VStack{
                HStack{
                    Text("Oops! something went wrong")
                    Text(vm.errorFeedback ?? "")
                    Spacer()
                    Button("Dismiss", action: vm.removeErrorFeedback)
                }
            }.padding()
                .background(.red)
                .cornerRadius(10)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
