//
//  CardTableViewCell.swift
//  doDep
//
//  Created by Assylzhan on 18.12.2025.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
