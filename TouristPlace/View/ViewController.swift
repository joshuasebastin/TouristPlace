//
//  ViewController.swift
//  TouristPlace
//
//  Created by Joshua on 10/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var touristDetailsTableview: UITableView!
     var floatingButton = UIButton()
    var placeDetailsMo:[placeDetailsModel] = [placeDetailsModel(image: "taj-Mahal", placeName: "Taj Mahal", placeDetails: "White marble mausoleum, symbol of love."),
                                              placeDetailsModel(image: "eiffel_tower", placeName: "Eiffel Tower", placeDetails: "Iron lattice tower, panoramic views of Paris."),
                                              placeDetailsModel(image: "colosseum", placeName: "Colosseum", placeDetails: "Oval amphitheater, gladiatorial contests."),
                                              placeDetailsModel(image: "great_wall_of_china", placeName: "Great Wall of China",placeDetails: "Series of fortifications, protects Chinese Empire."),
                                              placeDetailsModel(image: "angkor_wat.jpg", placeName: "Angkor Wat", placeDetails: "Massive temple complex, Hindu and Buddhist."),placeDetailsModel(image: "taj-Mahal", placeName: "Taj Mahal", placeDetails: "White marble mausoleum, symbol of love."),
                                              placeDetailsModel(image: "eiffel_tower", placeName: "Eiffel Tower", placeDetails: "Iron lattice tower, panoramic views of Paris."),
                                              placeDetailsModel(image: "colosseum", placeName: "Colosseum", placeDetails: "Oval amphitheater, gladiatorial contests."),
                                              placeDetailsModel(image: "great_wall_of_china", placeName: "Great Wall of China",placeDetails: "Series of fortifications, protects Chinese Empire."),
                                              placeDetailsModel(image: "angkor_wat.jpg", placeName: "Angkor Wat", placeDetails: "Massive temple complex, Hindu and Buddhist.")
    ]
    
    var filteredItems:[placeDetailsModel] = []
    var isSearchedTheItems:Bool = false
    var isSearchBarPinned = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageSetUp()
    }
    func pageSetUp(){
        touristDetailsTableview.register(UINib(nibName: "TouristImageTableViewCell", bundle: nil), forCellReuseIdentifier: "CouroselCell")
        touristDetailsTableview.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        touristDetailsTableview.register(UINib(nibName: "placesDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: Appdetails.shared.placeDetailCellIdentifier)
        touristDetailsTableview.delegate = self
        touristDetailsTableview.dataSource = self
        setUpInfoButton()
    }
    func setUpInfoButton(){
        floatingButton.backgroundColor = Appdetails.shared.infoButtonBgColor
        floatingButton.setTitle("", for: .normal)
        floatingButton.clipsToBounds = true
        floatingButton.setTitleColor(.white, for: .normal)
        floatingButton.setBackgroundImage(UIImage(named: "dots"), for: .normal)
        floatingButton.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
        view.addSubview(floatingButton)
        
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: touristDetailsTableview.bottomAnchor, constant: -20), // Adjust the constant as needed
            floatingButton.heightAnchor.constraint(equalToConstant: 50),
            floatingButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        floatingButton.layer.cornerRadius = 25
    }
    @objc func showBottomSheet() {
        let bottomSheetVC = BottomSheetViewController()
        
        let items = ["apple", "banana", "orange", "blueberry"]
        bottomSheetVC.items = items
        
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true 
            sheet.detents = [.medium(), .large()]
        }
        present(bottomSheetVC, animated: true, completion: nil)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y
            = 0
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section != 2 ? 1 : isSearchedTheItems ? filteredItems.count : placeDetailsMo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CouroselCell", for: indexPath) as? TouristImageTableViewCell {
                cell.placesCourselCollectionView.reloadData()
                return cell
            }
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell {
                cell.pageSetUp()
                cell.searchTextfield.delegate = self
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Appdetails.shared.placeDetailCellIdentifier, for: indexPath) as? placesDetailsTableViewCell {
                cell.bgView.backgroundColor = Appdetails.shared.PlaceDetailsCellBGColor
                cell.bgView.layer.cornerRadius = 10
                cell.bgView.clipsToBounds = true
               
                if isSearchedTheItems {
                    cell.iamgeView.image = UIImage(named: filteredItems[indexPath.row].image)
                    cell.placeDetails.text = filteredItems[indexPath.row].placeDetails
                    cell.placeName.text = filteredItems[indexPath.row].placeName
                } else {
                    cell.iamgeView.image = UIImage(named: placeDetailsMo[indexPath.row].image)
                    cell.placeDetails.text = placeDetailsMo[indexPath.row].placeDetails
                    cell.placeName.text = placeDetailsMo[indexPath.row].placeName
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension ViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text as NSString? {
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            isSearchedTheItems = updatedText.count == 0 ? false : true
            
            filteredItems = placeDetailsMo.filter { item in
                return item.placeName.lowercased().contains(updatedText.lowercased())
            }
            touristDetailsTableview.reloadSections([2], with: .automatic)
        }
        return true
    }
}
