//
//  MainViewModel.swift
//  BetterRest
//
//  Created by Yasser Bal on 12/11/2023.
//

import Foundation

class MainViewModel:ObservableObject
{
    public let MAX_HOURS_SLEEP = 12.0
    public let MIN_HOURS_SLEEP = 4.0
    
    public let MAX_CUPS_COFFEE = 20
    public let MIN_CUPS_COFFEE = 0
    
    @Published var wakeDate:Date = Date.now;
    @Published var amountOfSleepInHours:Double = 8.0
    @Published var cupsOfCoffeeDrank = 1
}
