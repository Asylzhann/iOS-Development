//
//  DetailViewController.swift
//  Lab8
//
//  Created by Assylzhan on 21.11.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item: FavouriteItem?
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionText: UITextView!
    @IBOutlet private weak var reviewLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item{
            nameLabel.text = item.name
            imageView.image = item.image
            descriptionText.text = item.description
            reviewLabel.text = item.review
        }
    }
    
}
