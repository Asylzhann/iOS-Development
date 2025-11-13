//
//  ViewController.swift
//  Lab7
//
//  Created by Assylzhan on 12.11.2025.
//

import UIKit

struct FavouriteItem{
    let title: String
    let subtitle: String
    let review: String
    let image: UIImage
    
    let fileName: String
    let fileType: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let movies: [FavouriteItem] = [
        FavouriteItem(
            title: "La La Land",
            subtitle: "A passionate story of love, dreams, and ambition set in Los Angeles, highlighting the struggles and triumphs of artists trying to make it big in Hollywood.",
            review: "9.8⭐️", image: .lalaland, fileName: "lalaland", fileType: "mp4"
        ),
        FavouriteItem(
            title: "Drive",
            subtitle: "A thrilling ride with a mysterious stunt driver navigating a dangerous world of crime, tension, and personal morality, showcasing intense action and emotional depth.",
            review: "9.2⭐️", image: .drive,fileName: "drive",fileType: "mp4"
        ),
        FavouriteItem(
            title: "Blade Runner 2049",
            subtitle: "A visually breathtaking futuristic story exploring identity, memory, and what it truly means to be human, set against a dystopian backdrop with stunning cinematography.",
            review: "9.5⭐️", image: .bladerunner,fileName: "bladerunner",fileType: "mp4"
        ),
        FavouriteItem(
            title: "Barbie",
            subtitle: "A vibrant and imaginative adventure that cleverly mixes humor, fantasy, and heartwarming lessons about self-discovery and friendship.",
            review: "9.0⭐️", image: .barbie,fileName: "barbie",fileType: "mp4"
        ),
        FavouriteItem(
            title: "The Fall Guy",
            subtitle: "A hilarious and charming story following a stuntman navigating action, romance, and comedy in unpredictable scenarios, full of charm and wit.",
            review: "8.8⭐️", image: .fallguy,fileName: "fallguy",fileType: "mp4"
        )
    ]

    let musics: [FavouriteItem] = [
        FavouriteItem(
            title: "Borderline",
            subtitle: "A groovy and introspective track with layered textures, blending melancholic lyrics with a mesmerizing rhythm, perfect for reflective moods.",
            review: "9.1⭐️", image: .borderline,fileName: "borderline",fileType: "mp3"
        ),
        FavouriteItem(
            title: "Dracula",
            subtitle: "Dark, atmospheric music with hypnotic beats and haunting melodies, creating an immersive sonic experience.",
            review: "8.9⭐️", image: .dracula,fileName: "dracula",fileType: "mp3"
        ),
        FavouriteItem(
            title: "End Of Summer",
            subtitle: "Bittersweet tones and nostalgic harmonies that evoke memories of fleeting moments and the end of carefree days.",
            review: "9.3⭐️", image: .endofsummer,fileName: "endofsummer",fileType: "mp3"
        ),
        FavouriteItem(
            title: "Let It Happen",
            subtitle: "Psychedelic perfection with layered instrumentation and hypnotic rhythms that transport the listener into a mesmerizing auditory journey.",
            review: "9.4⭐️", image: .letithappen,fileName: "letithappen",fileType: "mp3"
        ),
        FavouriteItem(
            title: "Loser",
            subtitle: "Raw and introspective energy paired with compelling melodies, exploring vulnerability and self-reflection.",
            review: "9.0⭐️", image: .loser,fileName: "loser",fileType: "mp3"
        ),
        FavouriteItem(
            title: "Neverender",
            subtitle: "Soaring, emotional, and expansive soundscapes that evoke feelings of triumph and melancholy simultaneously.",
            review: "9.2⭐️", image: .neverender,fileName: "neverender",fileType: "mp3"
        ),
        FavouriteItem(
            title: "New Person, Same Old Mistakes",
            subtitle: "Smooth and hypnotic rhythms with reflective lyrics, capturing the cyclical nature of personal growth and mistakes.",
            review: "9.1⭐️", image: .newperson,fileName: "newperson",fileType: "mp3"
        ),
        FavouriteItem(
            title: "The Less I Know The Better",
            subtitle: "Catchy, emotional, and memorable with a perfect balance of upbeat grooves and introspective lyrics.",
            review: "9.3⭐️", image: .theless,fileName: "theless",fileType: "mp3"
        )
    ]

    let books: [FavouriteItem] = [
        FavouriteItem(
            title: "Harry Potter and Sorcerer’s Stone",
            subtitle: "The magical journey begins as Harry discovers his wizarding heritage, navigates the complexities of Hogwarts, and finds friendship, courage, and wonder.",
            review: "9.7⭐️", image: .sorcerer,fileName: "sorcerer",fileType: "pdf"
        ),
        FavouriteItem(
            title: "Harry Potter and Prisoner of Azkaban",
            subtitle: "Harry faces darker challenges, uncovers secrets about his past, and learns valuable lessons about trust, courage, and loyalty in a more complex magical world.",
            review: "9.8⭐️", image: .azkaban,fileName: "azkaban",fileType: "pdf"
        ),
        FavouriteItem(
            title: "Harry Potter and Goblet of Fire",
            subtitle: "Thrilling tournament adventures, high-stakes challenges, and growing friendships mark this installment, filled with action, suspense, and magic.",
            review: "9.6⭐️", image: .goblet,fileName: "goblet",fileType: "pdf"
        ),
        FavouriteItem(
            title: "Harry Potter and Order of the Phoenix",
            subtitle: "A deeper, more emotional narrative exploring the weight of responsibility, the power of friendship, and confronting internal and external conflicts.",
            review: "9.7⭐️", image: .phoenix,fileName: "phoenix",fileType: "pdf"
        ),
        FavouriteItem(
            title: "Harry Potter and Deathly Hallows",
            subtitle: "An epic finale full of suspense, emotion, and resolution, where every secret is revealed and the ultimate battle between good and evil unfolds.",
            review: "9.9⭐️", image: .hallows,fileName: "hallows",fileType: "pdf"
        )
    ]

    let courses: [FavouriteItem] = [
        FavouriteItem(
            title: "Basics of Information Systems",
            subtitle: "An in-depth introduction to information systems concepts, their components, and their significance in modern business environments. Covers hardware, software, data, and networking fundamentals.",
            review: "9.0⭐️", image: .bis,fileName: "bis",fileType: "pdf"
        ),
        FavouriteItem(
            title: "Fundamentals of Business for Information Systems",
            subtitle: "Exploring how business and technology align, including processes, strategy, decision-making, and real-world applications in modern organizations.",
            review: "9.2⭐️", image: .fbis,fileName: "fbis",fileType: "pdf"
        ),
        FavouriteItem(
            title: "Information and Communication Technologies",
            subtitle: "Covers core ICT principles, digital communications, networking technologies, and their application in real-world contexts.",
            review: "9.1⭐️", image: .ict,fileName: "ict",fileType: "pdf"
        ),
        FavouriteItem(
            title: "Software Engineering",
            subtitle: "Structured software development, including design patterns, testing, agile methodologies, and project management for building high-quality software.",
            review: "9.3⭐️", image: .soft,fileName: "soft",fileType: "pdf"
        ),
        FavouriteItem(
            title: "iOS Development",
            subtitle: "Building real-world iOS applications using Swift, Xcode, UIKit, and modern app architecture principles with hands-on project experience.",
            review: "9.4⭐️", image: .ios,fileName: "ios",fileType: "pdf"
        )
    ]
    
    lazy var items:[[FavouriteItem]]=[movies,musics,books,courses]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 320
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! FavouriteItemTableViewCell
        let currentItem = items[indexPath.section][indexPath.row]
        cell.configure(item:currentItem,parent: self, section: indexPath.section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0: return "Favourite Ryan Gosling Movies"
        case 1: return "Favourite Tame Impala Songs"
        case 2: return "Favourite Harry Potter Books"
        case 3: return "Favourite 3rd Year Courses"
        default : return nil
        }
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("IndexPath: \(indexPath.section)|\(indexPath.row)")
    }
}
