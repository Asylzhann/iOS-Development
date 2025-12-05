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
    @IBOutlet private weak var leftCounter: UILabel!
    @IBOutlet private weak var rightCounter: UILabel!

    var service = FighterService()
    var statCount1: Int = 0
    var statCount2: Int = 0
    
    var leftSideWins: Int = 0
    var rightSideWins: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.delegate = self
        
//        fighterText1.text = ""
//        fighterText2.text = ""
//        statsComparisonTextView.text = ""
//        fighterName1.text = ""
//        fighterName2.text = ""
//        winnerLabel.text = ""
//        leftCounter.text = ""
//        rightCounter.text = ""
        
        loadWinCounters()
        loadLastFight()
    }
    
    @IBAction func fightButtonTapped() {
        service.fetchFighters()
    }
    
    private func updateUI(_ model1: FighterModel, _ model2: FighterModel) {
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
        
        let stats1 = [
            model1.powerstats.intelligence,
            model1.powerstats.strength,
            model1.powerstats.speed,
            model1.powerstats.durability,
            model1.powerstats.power,
            model1.powerstats.combat
        ]
        let stats2 = [
            model2.powerstats.intelligence,
            model2.powerstats.strength,
            model2.powerstats.speed,
            model2.powerstats.durability,
            model2.powerstats.power,
            model2.powerstats.combat
        ]
        
        for i in 0..<stats1.count {
            if stats1[i] > stats2[i] {
                statsComparisonTextView.text.append(">\n")
                statCount1 += 1
            } else if stats1[i] < stats2[i] {
                statsComparisonTextView.text.append("<\n")
                statCount2 += 1
            } else {
                statsComparisonTextView.text.append("=\n")
            }
        }
        
        if statCount1 > statCount2 {
            winnerLabel.text = "\(model1.name) wins!"
            leftSideWins += 1
        } else if statCount2 > statCount1 {
            winnerLabel.text = "\(model2.name) wins!"
            rightSideWins += 1
        } else { winnerLabel.text = "Tie!"}
        
        leftCounter.text = "\(leftSideWins)"
        rightCounter.text = "\(rightSideWins)"
        
        saveLastFight(model1, model2)
        saveWinCounters()
    }
    
    private func saveLastFight(_ model1: FighterModel, _ model2: FighterModel) {
        let fighterData1 = try? PropertyListEncoder().encode(model1)
        let fighterData2 = try? PropertyListEncoder().encode(model2)
        UserDefaults.standard.set(fighterData1, forKey: "fighter1")
        UserDefaults.standard.set(fighterData2, forKey: "fighter2")
    }
    private func loadLastFight(){
        guard
            let fighterData1 = UserDefaults.standard.data(forKey: "fighter1"),
            let fighterModel1 = try? PropertyListDecoder().decode(FighterModel.self, from: fighterData1),
            let fighterData2 = UserDefaults.standard.data(forKey: "fighter2"),
            let fighterModel2 = try? PropertyListDecoder().decode(FighterModel.self, from: fighterData2)
        else { return }
        updateUI(fighterModel1, fighterModel2)
    }
    
    private func saveWinCounters(){
        UserDefaults.standard.set(leftSideWins, forKey: "leftSideWins")
        UserDefaults.standard.set(rightSideWins, forKey: "rightSideWins")
    }
    private func loadWinCounters(){
        leftSideWins = UserDefaults.standard.integer(forKey: "leftSideWins")
        rightSideWins = UserDefaults.standard.integer(forKey: "rightSideWins")
        leftCounter.text="\(leftSideWins)"
        rightCounter.text="\(rightSideWins)"
    }
}

extension ViewController: FighterServiceDelegate{
    func onFightersFetched(model1: FighterModel, model2: FighterModel) {
        updateUI(model1, model2)
    }
}
