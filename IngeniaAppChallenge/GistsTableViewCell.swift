//
//  GistsTableViewCell.swift
//  IngeniaAppChallenge
//
//  Created by Osmar Hernández on 28/08/19.
//  Copyright © 2019 Ingenia. All rights reserved.
//

import UIKit

class GistsTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.cornerRadius = 40
            avatarImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
