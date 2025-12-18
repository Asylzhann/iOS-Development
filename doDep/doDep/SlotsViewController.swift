//
//  SlotsViewController.swift
//  doDep
//
//  Created by Assylzhan on 15.12.2025.
//

import UIKit

class SlotsViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var betAmountTextbox: UITextField!
        
    let slots: [String] = ["🍋","🍌","🍇","🥝","🍒"]
    
    var component1: [Int] = []
    var component2: [Int] = []
    var component3: [Int] = []
    
    var timers: [Timer?] = [nil, nil, nil]
    var currentRows = [0, 0, 0]
    var startRows   = [0, 0, 0]
    
    let rollDistance = [16, 20, 24]
    
    var stoppedCount = 0
    
    var bet = 100
    let minBet = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = ""
        betAmountTextbox.keyboardType = .numberPad
        betAmountTextbox.text = "\(bet)"
        
        updateBalanceLabel()
        
        for _ in 0...rollDistance[0] + 2 { component1.append(Int.random(in: 0..<slots.count)) }
        for _ in 0...rollDistance[1] + 2 { component2.append(Int.random(in: 0..<slots.count)) }
        for _ in 0...rollDistance[2] + 2 { component3.append(Int.random(in: 0..<slots.count)) }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.selectRow(1, inComponent: 0, animated: false)
        pickerView.selectRow(1, inComponent: 1, animated: false)
        pickerView.selectRow(1, inComponent: 2, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBalanceLabel), name: NSNotification.Name("BalanceChanged"), object: nil)
        updateBalanceLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBalanceLabel()
    }
    
    @IBAction func spinButtonTapped(_ sender: Any) {
        view.endEditing(true)
        
        guard readBet() else { return }
        
        spinButton.isEnabled = false
        resultLabel.text = ""
        stoppedCount = 0
        
        BalanceManager.shared.balance -= bet
        updateBalanceLabel()
        
        for _ in 0..<rollDistance[0] { component1.append(Int.random(in: 0..<slots.count)) }
        for _ in 0..<rollDistance[1] { component2.append(Int.random(in: 0..<slots.count)) }
        for _ in 0..<rollDistance[2] { component3.append(Int.random(in: 0..<slots.count)) }
        
        for component in 0..<3 {
            timers[component]?.invalidate()
            startRows[component] = currentRows[component]
            
            timers[component] = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) {
                _ in self.spin(component: component)
            }
        }
    }
    
    func spin(component: Int) {
        currentRows[component] += 1
        pickerView.selectRow(currentRows[component], inComponent: component, animated: true)
        
        if currentRows[component] >= startRows[component] + rollDistance[component] {
            timers[component]?.invalidate()
            stoppedCount += 1
            
            if stoppedCount == 3 {
                evaluateResult()
                spinButton.isEnabled = BalanceManager.shared.balance >= minBet
            }
        }
    }
    
    func evaluateResult() {
        let a = component1[currentRows[0]]
        let b = component2[currentRows[1]]
        let c = component3[currentRows[2]]
        
        let isWinBy3 = (a == b && b == c)
        let isWinBy2 = (a == b || b == c || a == c)
        
        var baseWin: Double = 0
        
        if isWinBy3 {
            baseWin = Double(bet) * 4.0
            resultLabel.text = "jackpot!"
        } else if isWinBy2 {
            baseWin = Double(bet) * 2.0
            resultLabel.text = "you win)"
        } else {
            resultLabel.text = "you lose("
        }
        
        if isWinBy2 || isWinBy3 {
            if bet >= 1000 {
                if let _ = CardManager.shared.rollCard() {
                    let alert = UIAlertController(title: "congrats!", message: "you won a card", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
        
        if baseWin > 0 {
            let cardBonusMultiplier = CardManager.shared.getWinMultiplier()
            let finalWin = Int(baseWin * cardBonusMultiplier)
            
            BalanceManager.shared.balance += finalWin
            resultLabel.text! += " +\(finalWin)"
        }
        
        updateBalanceLabel()
    }

    func readBet() -> Bool {
        guard let text = betAmountTextbox.text, let value = Int(text), value >= minBet, value <= BalanceManager.shared.balance
        else {
            resultLabel.text = "Invalid bet"
            return false
        }
        bet = value
        return true
    }
    
    @IBAction func plus100ButtonTapped(_ sender: Any) {
        let current = Int(betAmountTextbox.text ?? "") ?? bet
        let newBet = min(current + 100, BalanceManager.shared.balance)
        betAmountTextbox.text = "\(newBet)"
    }
    
    @IBAction func minus100ButtonTapped(_ sender: Any) {
        let current = Int(betAmountTextbox.text ?? "") ?? bet
        let newBet = max(current - 100, minBet)
        betAmountTextbox.text = "\(newBet)"
    }
    
    @IBAction func allInButtonTapped(_ sender: Any) {
        betAmountTextbox.text = "\(BalanceManager.shared.balance)"
    }
    
    @objc func updateBalanceLabel() {
        balanceLabel.text = "Balance: \(BalanceManager.shared.balance)"
        spinButton.isEnabled = BalanceManager.shared.balance >= minBet
    }
}

extension SlotsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {1_000_000}
    func numberOfComponents(in pickerView: UIPickerView) -> Int {3}
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {100}
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {100}
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        
        switch component {
        case 0: label.text = slots[component1[row]]
        case 1: label.text = slots[component2[row]]
        case 2: label.text = slots[component3[row]]
        default: break
        }
        
        label.font = UIFont(name: "Apple Color Emoji", size: 70)
        label.textAlignment = .center
        return label
    }
}
