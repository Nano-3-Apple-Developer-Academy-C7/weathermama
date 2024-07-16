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
    
    var hour: Int = 0 {
        didSet {
            updateSelectionState()
        }
    }
    
    var currentHour: Int = 0 {
        didSet {
            updateSelectionState()
        }
    }
    
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
        
        if isSelected && hour == currentHour {
            // Apply bottom border with desired properties to indicate selection
            let borderWidth: CGFloat = 1.0
            let borderColor: UIColor = .wmGray
            
            bottomBorderView = UIView()
            bottomBorderView?.backgroundColor = borderColor
            self.contentView.addSubview(bottomBorderView!)
            
            bottomBorderView?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bottomBorderView!.heightAnchor.constraint(equalToConstant: borderWidth),
                bottomBorderView!.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 95),
                bottomBorderView!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                bottomBorderView!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            ])
            
            // Adjust contentView's frame to maintain the specified size
            self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.contentView.frame.origin.y, width: 49, height: 101)
        }
    }
    
    private func clockSetup() {
        guard clockView == nil else { return }
        
        clockView = ClockWithSymbolView()
        clockView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(clockView!)
        
        NSLayoutConstraint.activate([
            clockView!.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            clockView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            clockView!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            clockView!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
}
