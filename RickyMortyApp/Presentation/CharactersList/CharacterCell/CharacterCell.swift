//
//  CharacterCell.swift
//  RickyMortyApp
//
//  Created by Kevin Heredia on 3/12/24.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    static let identifier = String(describing: CharacterCell.self)

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
