//
//  placesDetailsTableViewCell.swift
//  TouristPlace
//
//  Created by Joshua on 10/10/24.
//

import UIKit

class placesDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var placeDetails: UILabel!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iamgeView.layer.cornerRadius = 10
        iamgeView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
