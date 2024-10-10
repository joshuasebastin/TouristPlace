//
//  placesImageCollectionViewCell.swift
//  TouristPlace
//
//  Created by Joshua on 10/10/24.
//

import UIKit

class placesImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        placeImageView.layer.cornerRadius = 10
        placeImageView.clipsToBounds = true
    }

}
