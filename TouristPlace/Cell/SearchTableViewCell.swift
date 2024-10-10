//
//  SearchTableViewCell.swift
//  TouristPlace
//
//  Created by Joshua on 10/10/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTextfield: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func pageSetUp(){
        let searchImage = UIImage(systemName: "magnifyingglass")!
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(searchImage, for: .normal)
        searchButton.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        searchTextfield.leftView = searchButton
        searchTextfield.leftViewMode = .always
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
