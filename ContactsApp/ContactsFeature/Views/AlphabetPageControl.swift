//
//  AlphabetPageControl.swift
//  ContactsApp
//
//  Created by Yuvraj Sahu on 18/12/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

class AlphabetPageControl: UIStackView {
    var selectedIndex = -1 {
        willSet {
            if let label = getLabel(index: selectedIndex) {
                label.textColor = .black
            }
        }
        didSet {
            if let label = getLabel(index: selectedIndex) {
                label.textColor = .green
            }
        }
    }
    
    func addAphabets(chars : [Character]) {
        for char in chars {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
            label.text = String(char)
            self.addArrangedSubview(label)
        }
    }
    
    private func getLabel(index : Int) -> UILabel? {
        guard index < 0 || index >= self.arrangedSubviews.count else { return nil }
        guard let label = self.arrangedSubviews[index] as? UILabel else { return nil }
        return label
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
