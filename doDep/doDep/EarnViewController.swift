//
//  EarnViewController.swift
//  doDep
//
//  Created by Assylzhan on 18.12.2025.
//

import UIKit

class EarnViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    
    var spawnTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBalanceLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBalanceLabel()
        startGame()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        spawnTimer?.invalidate()
    }
    
    func startGame() {
        spawnTimer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { [weak self] _ in
            self?.createRandomCircle()
        }
    }
    
    func createRandomCircle() {
        let isBonus = Int.random(in: 1...5) == 1
        
        let value = isBonus ? 20 : 10
        let size: CGFloat = isBonus ? 35 : 50
        let circleColor: UIColor = isBonus ? .systemOrange : .systemYellow
        let lifespan: Double = isBonus ? 0.8 : 1.5
        
        let padding: CGFloat = 60
        let screenWidth = view.bounds.width - (padding * 2)
        let screenHeight = view.bounds.height - (padding * 4)
        
        let randomX = CGFloat.random(in: padding...screenWidth)
        let randomY = CGFloat.random(in: padding * 2...screenHeight)
        
        let circle = UIButton(frame: CGRect(x: randomX, y: randomY, width: size, height: size))
        circle.backgroundColor = circleColor
        circle.layer.cornerRadius = size / 2
        circle.setTitle("$\(value)", for: .normal)
        circle.titleLabel?.font = .systemFont(ofSize: isBonus ? 12 : 14, weight: .bold)
        
        circle.tag = value
        
        circle.addTarget(self, action: #selector(circleTapped(_:)), for: .touchUpInside)
        
        circle.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        view.addSubview(circle)
        
        UIView.animate(withDuration: 0.3) {
            circle.transform = .identity
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + lifespan) {
            self.removeCircle(circle)
        }
    }
    
    @objc func circleTapped(_ sender: UIButton) {
        let rewardAmount = sender.tag
        
        BalanceManager.shared.balance += rewardAmount
        updateBalanceLabel()
        
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            sender.alpha = 0
        }) { _ in
            sender.removeFromSuperview()
        }
        
    }
    
    func removeCircle(_ circle: UIButton) {
        guard circle.superview != nil else { return }
        UIView.animate(withDuration: 0.3, animations: {
            circle.alpha = 0
        }) { _ in
            circle.removeFromSuperview()
        }
    }
    
    func updateBalanceLabel() {
        balanceLabel.text = "Balance: \(BalanceManager.shared.balance)"
    }
}
