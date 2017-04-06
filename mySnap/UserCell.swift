//
//  UseCell.swift
//  mySnap
//
//  Created by Joy on 4/6/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func updateUI(user: User) {
        firstName.text = user.firstrName
    }

    func setCheckmark(selectd: Bool) {
        let imageStr = selectd ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }

}
