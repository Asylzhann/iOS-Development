//
//  ItemTableViewCell.swift
//  Lab8
//
//  Created by Assylzhan on 21.11.2025.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var itemName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: FavouriteItem) {
        icon.image = item.image
        itemName.text = item.name
    }
}
