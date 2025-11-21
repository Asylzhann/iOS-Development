//
//  CollectionViewController.swift
//  Lab8
//
//  Created by Assylzhan on 21.11.2025.
//

import UIKit

struct FavouriteItem{
    let name: String
    let description: String
    let review: String
    let image: UIImage
}

class CollectionViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let items: [[FavouriteItem]] = [[
        FavouriteItem(name: "Inception", description: "A skilled thief is given a chance at redemption if he can successfully perform inception on a target’s mind. Action-packed with mind-bending twists.", review: "My review: 9.8⭐", image: .inception),
        FavouriteItem(name: "The Matrix", description: "A computer hacker learns about the true nature of reality and his role in the war against its controllers.", review: "My review: 9.5⭐", image: .thematrix),
        FavouriteItem(name: "Interstellar", description: "Astronauts travel through a wormhole to find a new habitable planet for humanity as Earth faces extinction.", review: "My review: 9.6⭐", image: .interstellar),
        FavouriteItem(name: "The Dark Knight", description: "Batman battles the Joker who wants to create chaos in Gotham City. Dark, intense, and brilliantly acted.", review: "My review: 9.9⭐", image: .thedarkknight),
        FavouriteItem(name: "Titanic", description: "A romance blossoms aboard the ill-fated Titanic. Epic love story with historical tragedy.", review: "My review: 9.3⭐", image: .titanic),
        FavouriteItem(name: "Avatar", description: "A paraplegic marine explores the world of Pandora and joins a struggle to save the native Na'vi.", review: "My review: 9.2⭐", image: .avatar),
        FavouriteItem(name: "Gladiator", description: "A betrayed Roman general seeks revenge in the arenas of Rome. Powerful story of honor and courage.", review: "My review: 9.4⭐", image: .gladiator),
        FavouriteItem(name: "Forrest Gump", description: "Life story of Forrest, a man with a kind heart and low IQ, impacting historical events in the 20th century.", review: "My review: 9.7⭐", image: .forrestgump),
        FavouriteItem(name: "The Lord of the Rings", description: "A hobbit embarks on a journey to destroy a powerful ring, encountering friendship, danger, and epic battles.", review: "My review: 9.9⭐", image: .lotr),
        FavouriteItem(name: "Jurassic Park", description: "Scientists clone dinosaurs for a theme park, but chaos ensues when nature takes its course.", review: "My review: 9.1⭐", image: .jurassic)
    ],[
        FavouriteItem(name: "Bohemian Rhapsody", description: "Classic rock anthem by Queen, blending opera, rock, and ballad styles.", review: "My review: 9.9⭐", image: .bohemian),
        FavouriteItem(name: "Imagine", description: "John Lennon’s iconic song about peace, hope, and unity.", review: "My review: 9.5⭐", image: .imagine),
        FavouriteItem(name: "Shape of You", description: "Upbeat pop hit by Ed Sheeran about romance and attraction.", review: "My review: 9.2⭐", image: .shape),
        FavouriteItem(name: "Billie Jean", description: "Michael Jackson’s classic, combining pop and funk with an unforgettable groove.", review: "My review: 9.7⭐", image: .billiejean),
        FavouriteItem(name: "Blinding Lights", description: "The Weeknd’s modern synthwave-inspired pop hit.", review: "My review: 9.3⭐", image: .blinding),
        FavouriteItem(name: "Smells Like Teen Spirit", description: "Nirvana’s grunge anthem that defined a generation.", review: "My review: 9.4⭐", image: .smellslike),
        FavouriteItem(name: "Rolling in the Deep", description: "Adele’s powerful vocals and emotional delivery shine in this song.", review: "My review: 9.6⭐", image: .rolling),
        FavouriteItem(name: "Hotel California", description: "The Eagles’ classic about a surreal, haunting experience in California.", review: "My review: 9.5⭐", image: .hotel),
        FavouriteItem(name: "Stairway to Heaven", description: "Led Zeppelin’s epic rock masterpiece, combining multiple genres.", review: "My review: 9.8⭐", image: .stairway),
        FavouriteItem(name: "Hey Jude", description: "The Beatles’ legendary sing-along ballad with universal appeal.", review: "My review: 9.7⭐", image: .heyjude)
    ],[
        FavouriteItem(name: "1984", description: "Dystopian novel exploring totalitarianism, surveillance, and freedom.", review: "My review: 9.6⭐", image: ._1984),
        FavouriteItem(name: "To Kill a Mockingbird", description: "Classic novel addressing racial injustice and morality through the eyes of a child.", review: "My review: 9.7⭐", image: .mockingbird),
        FavouriteItem(name: "Harry Potter and the Sorcerer’s Stone", description: "The first book in the magical Harry Potter series, full of adventure and friendship.", review: "My review: 9.5⭐", image: .sorcerer),
        FavouriteItem(name: "The Great Gatsby", description: "Explores themes of wealth, love, and the American Dream in the 1920s.", review: "My review: 9.3⭐", image: .gatsby),
        FavouriteItem(name: "Pride and Prejudice", description: "Romantic classic about love, manners, and societal expectations.", review: "My review: 9.4⭐", image: .pride),
        FavouriteItem(name: "The Hobbit", description: "Fantasy adventure of Bilbo Baggins, setting the stage for The Lord of the Rings.", review: "My review: 9.5⭐", image: .hobbit),
        FavouriteItem(name: "The Catcher in the Rye", description: "Coming-of-age story exploring teenage alienation and identity.", review: "My review: 9.2⭐", image: .catcher),
        FavouriteItem(name: "The Alchemist", description: "A journey of self-discovery and following one’s dreams.", review: "My review: 9.3⭐", image: .alchemist),
        FavouriteItem(name: "Moby Dick", description: "Epic tale of obsession and revenge on the high seas.", review: "My review: 9.1⭐", image: .mobydick),
        FavouriteItem(name: "The Chronicles of Narnia", description: "Fantasy series full of magic, adventure, and moral lessons.", review: "My review: 9.4⭐", image: .narnia)
    ],[
        FavouriteItem(name: "CSCI2105 Algorithms and Data Structures", description: "Learn fundamental algorithms and data structures, including sorting, searching, and complexity analysis.", review: "My review: 9.7⭐", image: .ads),
        FavouriteItem(name: "CSCI3115 Computer Architecture", description: "Study the organization and structure of computer systems, including CPUs, memory, and input/output.", review: "My review: 9.5⭐", image: .comparch),
        FavouriteItem(name: "CSCI2104 Databases", description: "Introduction to relational databases, SQL, normalization, and database design principles.", review: "My review: 9.6⭐", image: .databases),
        FavouriteItem(name: "CSCI2106 Object-Oriented Programming and Design", description: "Learn OOP concepts, design patterns, and software development principles using object-oriented design.", review: "My review: 9.8⭐", image: .oop),
        FavouriteItem(name: "PHE101 Physical Education I", description: "Basic physical training, fitness exercises, and sports to develop physical skills and endurance.", review: "My review: 9.2⭐", image: .phy1),
        FavouriteItem(name: "LAN1119 Russian Language", description: "Develop reading, writing, and conversational skills in Russian, focusing on grammar and vocabulary.", review: "My review: 9.4⭐", image: .ru),
        FavouriteItem(name: "CSCI2109 Computer Networks and Architecture", description: "Study network protocols, architectures, and communication methods in computer networks.", review: "My review: 9.5⭐", image: .cna),
        FavouriteItem(name: "CSCI3238 Information Theory", description: "Learn about the mathematical foundations of information, entropy, and coding theory.", review: "My review: 9.6⭐", image: .inft),
        FavouriteItem(name: "INFT2204 Introduction to Business Management", description: "Covers basic principles of business management, organization, and decision-making.", review: "My review: 9.3⭐", image: .ibm),
        FavouriteItem(name: "INFT2205 Web Development", description: "Learn to build web applications, including front-end and back-end development with practical projects.", review: "My review: 9.7⭐", image: .webdev)
    ]]
    
    var selectedItem: FavouriteItem?
    var itemTypeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.item = selectedItem
    }
}

extension CollectionViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let index = tabBarController?.selectedIndex {
//            print("This is tab \(index)")
            itemTypeIndex = index
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        let item = items[itemTypeIndex][indexPath.row]
        cell.configure(item:item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = items[itemTypeIndex][indexPath.row]
//        print(indexPath)
        performSegue(withIdentifier: "detail", sender: self)
    }
}
