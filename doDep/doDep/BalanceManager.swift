//
//  BalanceManager.swift
//  doDep
//
//  Created by Assylzhan on 17.12.2025.
//

import Foundation
class BalanceManager {
    static let shared = BalanceManager()
    private let storageKey = "UserBalance"
    
    var balance: Int {
        didSet {
            UserDefaults.standard.set(balance, forKey: storageKey)
        }
    }
    
    private var passiveTimer: Timer?
    
    private init() {
        self.balance = UserDefaults.standard.integer(forKey: storageKey)
        if UserDefaults.standard.object(forKey: storageKey) == nil {
            self.balance = 10000 //2000
        }
        startPassiveIncome()
    }

    private func calculatePassiveRate() -> Int {
        var rate = 0
        let owned = CardManager.shared.ownedCardIDs
        if owned.contains(149) { rate += 1 }
        if owned.contains(370) { rate += 1 }
        if owned.contains(655) { rate += 2 }
        return rate
    }
    
    private func startPassiveIncome() {
        passiveTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let income = self.calculatePassiveRate()
            if income > 0 {
                self.balance += income
                NotificationCenter.default.post(name: NSNotification.Name("BalanceChanged"), object: nil)
            }
        }
    }
}
