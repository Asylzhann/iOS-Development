//
//  RouletteViewController.swift
//  doDep
//
//  Created by Assylzhan on 17.12.2025.
//

import UIKit

class RouletteViewController: UIViewController {
    
    @IBOutlet weak var rouletteWheel: UIImageView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var betAmountTextbox: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    enum BetType {
        case red, black, odd, even, high, low, zero
    }
    
    var selectedBetType: BetType = .red
    
    let rouletteNumbers = [0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10,
        5, 24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26]
    
    // Standard European Red Numbers
    let redNumbers: Set<Int> = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
    
    let numberAngle = 360.0 / 37.0
    private var currentRotation: Double = 0
    
    var balance = 10_000
    var bet = 100
    let minBet = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Place your bet!"
        betAmountTextbox.keyboardType = .numberPad
        betAmountTextbox.text = "\(bet)"
        updateBalanceLabel()
    }
    
    @IBAction func spinButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard readBet() else { return }
        
        spinButton.isEnabled = false
        resultLabel.text = "Spinning..."
        balance -= bet
        updateBalanceLabel()
        
        let spins = Double.random(in: 5...8) * 360
        let offset = Double.random(in: 0..<360)
        let totalRotationDegrees = spins + offset
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        let startAngle = currentRotation * .pi / 180
        let endAngle = (currentRotation + totalRotationDegrees) * .pi / 180
        
        rotationAnimation.fromValue = startAngle
        rotationAnimation.toValue = endAngle
        rotationAnimation.duration = 3.0 //4.0
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        resultLabel.text = ""
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.currentRotation = (self.currentRotation + totalRotationDegrees).truncatingRemainder(dividingBy: 36000)
            let normalizedAngle = self.currentRotation.truncatingRemainder(dividingBy: 360)
            let resultNumber = self.calculateResult(angle: normalizedAngle)
            
            self.evaluateBet(result: resultNumber)
            self.spinButton.isEnabled = self.balance >= self.minBet
        }
        
        rouletteWheel.layer.add(rotationAnimation, forKey: "rotationAnimation")
        CATransaction.commit()
    }
    
    func calculateResult(angle: Double) -> Int {
        let corrected = (360 - angle).truncatingRemainder(dividingBy: 360)
        let index = Int((corrected + numberAngle / 2) / numberAngle) % 37
        return rouletteNumbers[index]
    }
    
    func evaluateBet(result: Int) {
        var didWin = false
        var multiplier = 2.0
        
        switch selectedBetType {
        case .red: didWin = redNumbers.contains(result)
        case .black: didWin = result != 0 && !redNumbers.contains(result)
        case .odd: didWin = result != 0 && result % 2 != 0
        case .even: didWin = result != 0 && result % 2 == 0
        case .high: didWin = result >= 19 && result <= 36
        case .low: didWin = result >= 1 && result <= 18
        case .zero: didWin = result == 0; multiplier = 35.0
        }
        
        if didWin {
            let winAmount = Int(Double(bet) * multiplier)
            balance += winAmount
            resultLabel.text = "\(result) — won)! +\(winAmount)"
        } else {
            resultLabel.text = "\(result) — lost("
        }
        
        updateBalanceLabel()
    }
    
    func readBet() -> Bool {
        guard let text = betAmountTextbox.text, let value = Int(text), value >= minBet, value <= balance else {
            resultLabel.text = "Invalid bet"
            return false
        }
        bet = value
        return true
    }
    
    func updateBalanceLabel() {
        balanceLabel.text = "Balance: \(balance)"
    }
    
    @IBAction func setBetType(_ sender: UIButton) {
        switch sender.tag {
        case 0: selectedBetType = .red
        case 1: selectedBetType = .black
        case 2: selectedBetType = .odd
        case 3: selectedBetType = .even
        case 4: selectedBetType = .high
        case 5: selectedBetType = .low
        case 6: selectedBetType = .zero
        default: break
        }
        resultLabel.text = "Bet placed"
    }

    @IBAction func plus100ButtonTapped(_ sender: Any) {
        let current = Int(betAmountTextbox.text ?? "") ?? bet
        let newBet = min(current + 100, balance)
        betAmountTextbox.text = "\(newBet)"
    }
    
    @IBAction func minus100ButtonTapped(_ sender: Any) {
        let current = Int(betAmountTextbox.text ?? "") ?? bet
        let newBet = max(current - 100, minBet)
        betAmountTextbox.text = "\(newBet)"
    }
    
    @IBAction func allInButtonTapped(_ sender: Any) {
        betAmountTextbox.text = "\(balance)"
    }
}
