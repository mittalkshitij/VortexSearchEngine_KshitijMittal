//
//  PhotoTableViewCell.swift
//  VortexApplication
//
//  Created by Kshitij Mittal on 09/02/23.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

 
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoName: UILabel!
    @IBOutlet weak var photoDetail: UITextView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }
        

}
