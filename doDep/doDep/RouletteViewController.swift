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
    @IBOutlet var betButtons: [UIButton]!
    
    enum BetType {
        case red, black, odd, even, high, low, zero
    }
    
    var selectedBetType: BetType = .red
    let rouletteNumbers = [0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10,
                           5, 24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26]
    let redNumbers: Set<Int> = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
    let numberAngle = 360.0 / 37.0
    private var currentRotation: Double = 0
    
    var bet = 100
    let minBet = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        betAmountTextbox.keyboardType = .numberPad
        betAmountTextbox.text = "\(bet)"
        updateBalanceLabel()
        updateButtonSelection(selectedTag: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBalanceLabel()
    }
    
    func updateButtonSelection(selectedTag: Int) {
        for button in betButtons {
            if button.tag == selectedTag {
                button.backgroundColor = .systemGray5
            } else {
                button.backgroundColor = .clear
            }
        }
    }
    
    @IBAction func setBetType(_ sender: UIButton) {
        let types: [BetType] = [.red, .black, .odd, .even, .high, .low, .zero]
        if sender.tag < types.count {
            selectedBetType = types[sender.tag]
            resultLabel.text = "Bet placed"
            updateButtonSelection(selectedTag: sender.tag)
        }
    }
    
    @IBAction func spinButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard readBet() else { return }
        
        spinButton.isEnabled = false
        resultLabel.text = "Spinning..."
        
        BalanceManager.shared.balance -= bet
        updateBalanceLabel()
        
        let spins = Double.random(in: 3...6) * 360
        let offset = Double.random(in: 0...360)
        let totalRotationDegrees = spins + offset
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        let startAngle = currentRotation * .pi / 180
        let endAngle = (currentRotation + totalRotationDegrees) * .pi / 180
        
        rotationAnimation.fromValue = startAngle
        rotationAnimation.toValue = endAngle
        
        rotationAnimation.duration = 4.5
        
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.currentRotation = (self.currentRotation + totalRotationDegrees).truncatingRemainder(dividingBy: 36000)
            let normalizedAngle = self.currentRotation.truncatingRemainder(dividingBy: 360)
            
            let resultNumber = self.calculateResult(angle: normalizedAngle)
            self.evaluateBet(result: resultNumber)
            self.spinButton.isEnabled = BalanceManager.shared.balance >= self.minBet
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
            BalanceManager.shared.balance += winAmount
            resultLabel.text = "\(result) — won! +\(winAmount)"
        } else {
            resultLabel.text = "\(result) — lost("
        }
        updateBalanceLabel()
    }
    
    func updateBalanceLabel() {
        balanceLabel.text = "Balance: \(BalanceManager.shared.balance)"
        spinButton.isEnabled = BalanceManager.shared.balance >= minBet
    }
    
    func readBet() -> Bool {
        guard let text = betAmountTextbox.text, let value = Int(text),
              value >= minBet, value <= BalanceManager.shared.balance else {
            resultLabel.text = "Invalid bet"
            return false
        }
        bet = value
        return true
    }
    
    @IBAction func plus100ButtonTapped(_ sender: Any) {
        let current = Int(betAmountTextbox.text ?? "") ?? bet
        betAmountTextbox.text = "\(min(current + 100, BalanceManager.shared.balance))"
    }
    
    @IBAction func minus100ButtonTapped(_ sender: Any) {
        let current = Int(betAmountTextbox.text ?? "") ?? bet
        betAmountTextbox.text = "\(max(current - 100, minBet))"
    }
    
    @IBAction func allInButtonTapped(_ sender: Any) {
        betAmountTextbox.text = "\(BalanceManager.shared.balance)"
    }
}
