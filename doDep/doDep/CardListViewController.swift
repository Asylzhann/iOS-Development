//
//  CardListViewController.swift
//  doDep
//
//  Created by Assylzhan on 18.12.2025.
//

import UIKit
import Alamofire
import Kingfisher

class CardListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var unlockedCards: [Card] = []
    private let selectedIDs: Set<Int> = [100, 687, 655, 644, 370, 313, 280, 149, 70, 194]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadInitialCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInitialCollection()
    }

    private func loadInitialCollection() {
        unlockedCards.removeAll()
        for id in CardManager.shared.ownedCardIDs {
            fetchCard(id: id)
        }
    }

    func fetchCard(id: Int) {
        guard selectedIDs.contains(id) else { return }
        
        let url = "https://akabab.github.io/superhero-api/api/id/\(id).json"
        
        AF.request(url).validate().responseDecodable(of: Card.self) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let newCard):
                if !self.unlockedCards.contains(where: { $0.id == newCard.id }) {
                    self.unlockedCards.append(newCard)
                    self.unlockedCards.sort { $0.id < $1.id }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching card \(id): \(error.localizedDescription)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unlockedCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! CardTableViewCell
        let card = unlockedCards[indexPath.row]

        cell.nameLabel.text = card.name
        cell.descriptionTextView.text = card.bonusDescription

        cell.heroImageView.kf.indicatorType = .activity
        cell.heroImageView.kf.setImage(with: URL(string: card.images.sm))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
    }
}
