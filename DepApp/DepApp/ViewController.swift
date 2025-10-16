//
//  ViewController.swift
//  DepApp
//
//  Created by Assylzhan on 09.10.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dice1: UIImageView!
    @IBOutlet weak var dice2: UIImageView!
    @IBOutlet weak var dice3: UIImageView!
    @IBOutlet weak var sum: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var eventText: UILabel!
    @IBOutlet weak var rollButton: UIButton!
    
    var b:Int=100
    var s:Int=0
    
    let diceImages:[UIImage]=[#imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix")]
    
    func randomiseDices()->Int{
        var s:Int=0
        let dices:[UIImageView]=[dice1,dice2,dice3]
        for dice in dices{
            let randomIndex:Int = Int.random(in: 0...5)
            dice.image=diceImages[randomIndex]
            s+=randomIndex+1
        }
        return s
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sum.text = ""
        balance.text = "Balance: 100"
        eventText.text=""
        var _ = randomiseDices()
    }
    
    
    @IBAction func rollButtonDidTap(_ sender: Any) {
        eventText.text=""
        if b<20{
            eventText.text="Not enough money"
        }
        if b>=20{
            s=randomiseDices()
            b-=20
            balance.text="Balance: \(b)"
            if s==3{
                b=20
                eventText.text="Death penalty"
            }
            if s==18{
                eventText.text="Jackpot!"
                if b<20{
                    b=40
                }
                else{
                    b*=2
                }
            }
            if 4<=s&&s<=10{
                eventText.text="You lost"
            }
            if 11<=s&&s<=17{
                b+=40
                eventText.text="You won"
            }
        }
        
        print(s)
        sum.text="Sum: \(s)"
        balance.text="Balance: \(b)"
    }
    
}
