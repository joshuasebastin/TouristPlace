//
//  TouristImageTableViewCell.swift
//  TouristPlace
//
//  Created by Joshua on 10/10/24.
//

import UIKit

class TouristImageTableViewCell: UITableViewCell {
    @IBOutlet weak var placesCourselCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let cellIndentifier = "PlacesCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        placesCourselCollectionView.register(UINib(nibName: "placesImageCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: cellIndentifier)
        placesCourselCollectionView.delegate = self
        placesCourselCollectionView.dataSource = self
        pageControl.numberOfPages = Appdetails.shared.touristPlaceImage.count
        pageControl.pageIndicatorTintColor = UIColor.darkGray
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let point = CGPoint(x: scrollView.contentOffset.x + scrollView.frame.width / 2, y: scrollView.contentOffset.y + scrollView.frame.height / 2)
           if let indexPath = placesCourselCollectionView.indexPathForItem(at: point) {
               pageControl.currentPage = indexPath.row
           }
       }
    
}
extension TouristImageTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Appdetails.shared.touristPlaceImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath) as? placesImageCollectionViewCell {
            cell.placeImageView.image = UIImage(named: Appdetails.shared.touristPlaceImage[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
extension TouristImageTableViewCell:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 180)
    }
}
