//
//  MainViewModel.swift
//  BetterRest
//
//  Created by Yasser Bal on 12/11/2023.
//

import Foundation
import CoreML

final class MainViewModel:ObservableObject
{
    public static var DEFAULT_WAKE_TIME:Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    public static let DEFAULT_HOURS_SLEEP = 8.0
    public static let DEFAULT_CUPS_COFFEE = 1
    
    public static let MAX_HOURS_SLEEP = 12.0
    public static let MIN_HOURS_SLEEP = 4.0
    
    public static let MAX_CUPS_COFFEE = 20
    public static let MIN_CUPS_COFFEE = 0
    
    @Published var inputWakeTime:Date = MainViewModel.DEFAULT_WAKE_TIME;
    

    
    @Published var inputHoursOfSleep:Double = MainViewModel.DEFAULT_HOURS_SLEEP
    @Published var inputCupsOfCoffeeDrank = MainViewModel.DEFAULT_CUPS_COFFEE
    
    var predictedSleepTime:Date? {
        let inputTimeComponents = Calendar.current.dateComponents(
            [.hour,.minute],
            from: inputWakeTime
        )
    
        let inputTimeSeconds =
            ((inputTimeComponents.hour ?? 0) * 60 * 60) +
            ((inputTimeComponents.minute ?? 0 ) * 60)
        
        do{
            guard let calculator = sleepCalculator else{
                errorFeedback = "Failed to load ML Model"
                return nil;
            }
            let prediction = try calculator.prediction(input: SleepCalcModelInput(
                    wake: Double(inputTimeSeconds),
                    estimatedSleep:inputHoursOfSleep ,
                    coffee: Double(inputCupsOfCoffeeDrank)
                ))
            
            return inputWakeTime - prediction.actualSleep
            
        }catch{
            errorFeedback = "Failed to calculate sleep prediction"
            return nil
        }
    }
    @Published var errorFeedback:String?
    
    private var sleepCalculator:SleepCalcModel?;
    
    
    init(){
        do{
            let config = MLModelConfiguration()
            
            self.sleepCalculator = try SleepCalcModel(
                configuration:config)
            self.errorFeedback = nil;
        }catch{
            //
            errorFeedback = "Failed to load ML Model"
        }
    }

    
    func removeErrorFeedback(){
        self.errorFeedback = nil
    }
}
