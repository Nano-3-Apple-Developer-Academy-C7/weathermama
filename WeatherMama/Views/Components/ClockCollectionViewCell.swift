//
//  ClockCollectionViewCell.swift
//  WeatherMama
//
//  Created by Lucky on 14/07/24.
//

import UIKit

class ClockCollectionViewCell: UICollectionViewCell {
    
    var clockView: ClockWithSymbolView?
    private var bottomBorderView: UIView?
    
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clockSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ClockCollectionViewCell {
    
    private func updateSelectionState() {
        bottomBorderView?.removeFromSuperview()
        
        if isSelected {
            // Apply bottom border with desired properties to indicate selection
            let borderWidth: CGFloat = 1.0
            let borderColor: UIColor = .wmGray
            
            bottomBorderView = UIView()
            bottomBorderView?.backgroundColor = borderColor
            self.contentView.addSubview(bottomBorderView!)
            
            bottomBorderView?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bottomBorderView!.heightAnchor.constraint(equalToConstant: borderWidth),
                bottomBorderView!.topAnchor.constraint(equalTo: clockView!.bottomAnchor, constant: 10),
                bottomBorderView!.widthAnchor.constraint(equalToConstant: 45),
                bottomBorderView!.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
            ])
        }
    }
    
    private func clockSetup() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        guard clockView == nil else { return }
        
        clockView = ClockWithSymbolView()
        clockView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(clockView!)
        
        NSLayoutConstraint.activate([
            clockView!.widthAnchor.constraint(equalToConstant: 28),
            clockView!.heightAnchor.constraint(equalToConstant: 90),
            
            clockView!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.5),
            clockView!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.5),
        ])
    }
}
