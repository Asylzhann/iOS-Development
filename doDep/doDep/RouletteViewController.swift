//
//  RouletteViewController.swift
//  doDep
//
//  Created by Assylzhan on 17.12.2025.
//

import UIKit

class RouletteViewController: UIViewController {
    
    private var rouletteWheel: RouletteView!
    private var spinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Initialize Roulette Wheel
        rouletteWheel = RouletteView(frame: CGRect(x: 50, y: 150, width: 300, height: 300))
        rouletteWheel.backgroundColor = .clear
        view.addSubview(rouletteWheel)
        
        // Initialize Spin Button
        spinButton = UIButton(type: .system)
        spinButton.frame = CGRect(x: 100, y: 500, width: 200, height: 50)
        spinButton.setTitle("Spin Roulette", for: .normal)
        spinButton.addTarget(self, action: #selector(spinRoulette), for: .touchUpInside)
        view.addSubview(spinButton)
    }
    
    @objc private func spinRoulette() {
        let randomAngle = CGFloat.random(in: 0..<CGFloat.pi * 2)
        let duration = TimeInterval.random(in: 1.5..<3.0)
        rouletteWheel.rotateWheel(toAngle: randomAngle, duration: duration)
    }
}

// Custom Roulette View Class
class RouletteView: UIView {
    
    private let numberOfSegments = 12
    private let colors: [UIColor] = [.red, .black, .green, .blue, .yellow, .purple] // Colors for segments

    private var segments: [CAShapeLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWheel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupWheel()
    }
    
    private func setupWheel() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        segments.removeAll()
        
        let radius = self.bounds.width / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let segmentAngle = CGFloat.pi * 2 / CGFloat(numberOfSegments)
        
        for i in 0..<numberOfSegments {
            let startAngle = segmentAngle * CGFloat(i)
            let endAngle = startAngle + segmentAngle
            
            // Create each segment
            let segmentLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.close()
            
            segmentLayer.path = path.cgPath
            segmentLayer.fillColor = colors[i % colors.count].cgColor
            self.layer.addSublayer(segmentLayer)
            segments.append(segmentLayer)
        }
    }
    
    func rotateWheel(toAngle angle: CGFloat, duration: TimeInterval) {
        let rotation = CGAffineTransform(rotationAngle: angle)
        UIView.animate(withDuration: duration, animations: {
            self.transform = rotation
        })
    }
}
