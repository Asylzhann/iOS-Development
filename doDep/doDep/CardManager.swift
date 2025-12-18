//
//  CardManager.swift
//  doDep
//
//  Created by Assylzhan on 18.12.2025.
//

import Foundation

class CardManager {
    static let shared = CardManager()
    private let storageKey = "OwnedCards"
    var ownedCardIDs: Set<Int> = []
//    var ownedCardIDs: Set<Int> = [100, 687, 655, 644, 370, 313, 280, 149, 70, 194]
    
    private init() {
        let saved = UserDefaults.standard.array(forKey: storageKey) as? [Int] ?? [70]
        ownedCardIDs = Set(saved)
    }
    
    func unlockCard(id: Int) -> Bool {
        if !ownedCardIDs.contains(id) {
            ownedCardIDs.insert(id)
            UserDefaults.standard.set(Array(ownedCardIDs), forKey: storageKey)
            return true
        }
        return false
    }
    
    func getTapBonus() -> Int {
        var bonus = 0
        if ownedCardIDs.contains(280) { bonus += 5 }
        if ownedCardIDs.contains(313) { bonus += 5 }
        if ownedCardIDs.contains(644) { bonus += 10 }
        return bonus
    }
    
    func getWinMultiplier() -> Double {
        var multiplier = 1.0
        
        if ownedCardIDs.contains(70)  { multiplier += 0.01 }
        if ownedCardIDs.contains(100) { multiplier += 0.02 }
        if ownedCardIDs.contains(194) { multiplier += 0.01 }
        if ownedCardIDs.contains(687) { multiplier += 0.01 }
        
        return multiplier
    }
    
    func rollCard() -> Int? {
        guard Int.random(in: 1...10) == 1 else { return nil }
        
        let selectedIDs: Set<Int> = [100, 687, 655, 644, 370, 313, 280, 149, 70, 194]
//        let lockedIDs = selectedIDs.subtracting(ownedCardIDs)
//        if let randomID = lockedIDs.randomElement() {
        if let randomID = selectedIDs.randomElement() {
            _ = unlockCard(id: randomID)
            return randomID
        }
        return nil
    }
}
