//
//  ViewController.swift
//  Fighting 2
//
//  Created by Assylzhan on 28.11.2025.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet private weak var fighterImageView1: UIImageView!
    @IBOutlet private weak var fighterImageView2: UIImageView!
    @IBOutlet private weak var fighterName1: UILabel!
    @IBOutlet private weak var fighterName2: UILabel!
    @IBOutlet private weak var winnerLabel: UILabel!
    @IBOutlet private weak var fighterText1: UITextView!
    @IBOutlet private weak var fighterText2: UITextView!
    @IBOutlet private weak var statsComparisonTextView: UITextView!
    @IBOutlet private weak var fightButton: UIButton!

    var service = FighterService()
    var statCount1: Int = 0
    var statCount2: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fighterText1.text = ""
        fighterText2.text = ""
        statsComparisonTextView.text = ""
        fighterName1.text = ""
        fighterName2.text = ""
        winnerLabel.text = ""
    }
    
    @IBAction func fightButtonTapped() {
        Task { @MainActor in
            let randomId1 = Int.random(in: 1...731)
            var randomId2 = Int.random(in: 1...731)
            if randomId1 == randomId2 {
                randomId2 = Int.random(in: 1...731)
            }
            
            guard let model1 = try? await service.fetchFighter(randomId1) else { return }
            guard let model2 = try? await service.fetchFighter(randomId2) else { return }
            
            if model1.biography.alignment == "good" {fighterName1.textColor = .green}
            if model1.biography.alignment == "bad" {fighterName1.textColor = .red}
            if model2.biography.alignment == "good" {fighterName2.textColor = .green}
            if model2.biography.alignment == "bad" {fighterName2.textColor = .red}
            
            fighterName1.text = model1.name
            fighterName2.text = model2.name
            
            fighterImageView1.kf.setImage(with: URL(string: model1.images.md))
            fighterImageView2.kf.setImage(with: URL(string: model2.images.md))
            
            fighterText1.text = """
            Intelligence: \(model1.powerstats.intelligence)
            Strength: \(model1.powerstats.strength)
            Speed: \(model1.powerstats.speed)
            Durability: \(model1.powerstats.durability)
            Power: \(model1.powerstats.power)
            Combat: \(model1.powerstats.combat)
            """

            fighterText2.text = """
            Intelligence: \(model2.powerstats.intelligence)
            Strength: \(model2.powerstats.strength)
            Speed: \(model2.powerstats.speed)
            Durability: \(model2.powerstats.durability)
            Power: \(model2.powerstats.power)
            Combat: \(model2.powerstats.combat)
            """
            
            statCount1 = 0
            statCount2 = 0
            statsComparisonTextView.text = ""
            
            if model1.powerstats.intelligence > model2.powerstats.intelligence {
                statsComparisonTextView.text.append(">\n")
                statCount1 += 1
            } else if model1.powerstats.intelligence < model2.powerstats.intelligence {
                statsComparisonTextView.text.append("<\n")
                statCount2 += 1
            } else {
                statsComparisonTextView.text.append("=\n")
            }
            
            if model1.powerstats.strength > model2.powerstats.strength {
                statsComparisonTextView.text.append(">\n")
                statCount1 += 1
            } else if model1.powerstats.strength < model2.powerstats.strength {
                statsComparisonTextView.text.append("<\n")
                statCount2 += 1
            } else {
                statsComparisonTextView.text.append("=\n")
            }
            
            if model1.powerstats.speed > model2.powerstats.speed {
                statsComparisonTextView.text.append(">\n")
                statCount1 += 1
            } else if model1.powerstats.speed < model2.powerstats.speed {
                statsComparisonTextView.text.append("<\n")
                statCount2 += 1
            } else {
                statsComparisonTextView.text.append("=\n")
            }
            
            if model1.powerstats.durability > model2.powerstats.durability {
                statsComparisonTextView.text.append(">\n")
                statCount1 += 1
            } else if model1.powerstats.durability < model2.powerstats.durability {
                statsComparisonTextView.text.append("<\n")
                statCount2 += 1
            } else {
                statsComparisonTextView.text.append("=\n")
            }
            
            if model1.powerstats.power > model2.powerstats.power {
                statsComparisonTextView.text.append(">\n")
                statCount1 += 1
            } else if model1.powerstats.power < model2.powerstats.power {
                statsComparisonTextView.text.append("<\n")
                statCount2 += 1
            } else {
                statsComparisonTextView.text.append("=\n")
            }
            
            if model1.powerstats.combat > model2.powerstats.combat {
                statsComparisonTextView.text.append(">\n")
                statCount1 += 1
            } else if model1.powerstats.combat < model2.powerstats.combat {
                statsComparisonTextView.text.append("<\n")
                statCount2 += 1
            } else {
                statsComparisonTextView.text.append("=\n")
            }
            
            if statCount1 > statCount2 {
                winnerLabel.text = "\(model1.name) wins!"
            } else if statCount2 > statCount1 {
                winnerLabel.text = "\(model2.name) wins!"
            } else { winnerLabel.text = "Tie!"}
        }
    }
}
