//
//  BottomSheetViewController.swift
//  TouristPlace
//
//  Created by Joshua on 10/10/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBottomSheetContent()
    }
    func setupBottomSheetContent() {
        // Create a label to display statistics
        let statisticsLabel = UILabel()
        statisticsLabel.numberOfLines = 0
        statisticsLabel.text = "List 1 (\(items.count) items)\n"
        
        let characterCounts = calculateCharacterCounts(items)
               let top3Characters = characterCounts.sorted { $0.value > $1.value }.prefix(3)
               for (character, count) in top3Characters {
                   statisticsLabel.text! += "\(character) = \(count)\n"
               }
        
        view.addSubview(statisticsLabel)
        statisticsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statisticsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statisticsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statisticsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statisticsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    private func calculateCharacterCounts(_ items: [String]) -> [Character: Int] {
        var characterCounts: [Character: Int] = [:]
        for item in items {
            for character in item {
                characterCounts[character] = (characterCounts[character] ?? 0) + 1
            }
        }
        return characterCounts
    }
}
