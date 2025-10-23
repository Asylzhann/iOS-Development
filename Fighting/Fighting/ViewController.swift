//
//  ViewController.swift
//  Fighting
//
//  Created by Assylzhan on 17.10.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var labelName1: UILabel!
    @IBOutlet weak var labelName2: UILabel!
    @IBOutlet weak var labelWinner: UILabel!
    
    let heroes: [String: UIImage] = [
        "Ant-man": .antman,
        "Black Panther": .blackpanther,
        "Black Widow": .blackwidow,
        "Captain America": .captainamerica,
        "Captain Marvel": .captainmarvel,
        "Hawkeye": .hawkeye,
        "Hulk": .hulk,
        "Iceman": .iceman,
        "Iron Man": .ironman,
        "Moon Knight": .moonknight,
        "Scarlet Witch": .scarletwitch,
        "Silver Surfer": .silversurfer,
        "Spider-man": .spiderman,
        "Star-Lord": .starlord,
        "Thor": .thor,
        "Wolverine": .wolverine
    ]
    var hero1name: String? = ""
    var hero2name: String? = ""

    func rollRandomHero1(){
        let randomHero = heroes.randomElement()
        image1.image = randomHero?.value
        hero1name = randomHero?.key
        labelName1.text = hero1name
        labelWinner.text=""
    }
    func rollRandomHero2(){
        let randomHero = heroes.randomElement()
        image2.image = randomHero?.value
        hero2name = randomHero?.key
        labelName2.text = hero2name
        labelWinner.text=""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rollRandomHero1()
        rollRandomHero2()
        image2.transform = CGAffineTransform(scaleX: -1, y: 1)
        labelWinner.text = ""
    }

    @IBAction func rollButton1DidTap(_ sender: UIButton) {
        rollRandomHero1()
    }
    @IBAction func rollButton2DidTap(_ sender: UIButton) {
        rollRandomHero2()
    }
    @IBAction func FightDidTap(_ sender: UIButton) {
        let winner = Int.random(in: 0...1)
        if winner==0{
            if let name=hero1name{
                labelWinner.text = "\(name) wins!"
            } else{
                labelWinner.text = "Friendship wins!"
            }
        }
        else{
            if let name=hero2name{
                labelWinner.text = "\(name) wins!"
            } else{
                labelWinner.text = "Friendship wins!"
            }
        }
    }
}

