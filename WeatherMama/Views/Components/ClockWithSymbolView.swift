//
//  ClockWithSymbolView.swift
//  WeatherMama
//
//  Created by Lucky on 14/07/24.
//

import UIKit

class ClockWithSymbolView: UIView {
    private lazy var clockStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private lazy var  hourLabel: UILabel = {
        let hourLabel = UILabel()
        hourLabel.text = "1"
        hourLabel.font = UIFont(name: "SFProRounded-Regular", size: 14)
        hourLabel.textColor = .label
        hourLabel.textAlignment = .center
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return hourLabel
    }()
    
    private lazy var  symbolView: UIImageView = {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24)
        let symbolImage = UIImage(systemName: "sun.max", withConfiguration: symbolConfig)
        
        let symbolView = UIImageView(image: symbolImage)
        symbolView.tintColor = .orange
        symbolView.contentMode = .scaleAspectFit
        symbolView.frame = CGRect(x: 0, y: 0, width: 28, height: 27)
        
        return symbolView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupClock()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ClockWithSymbolView {
    func setHour(_ hour: Int) {
        hourLabel.text = String(format: "%d", hour)
    }
    
    func setHourColor(_ color: UIColor) {
        hourLabel.textColor = color
    }
    
    func setSymbol(_ systemName: String) {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24)
        let symbolImage = UIImage(systemName: systemName, withConfiguration: symbolConfig)
        symbolView.image = symbolImage
    }
    
    func setSymbolColor(_ color: UIColor) {
        symbolView.tintColor = color
    }
}

private extension ClockWithSymbolView {
    
    private func setupClock() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(clockStackView)
        
        NSLayoutConstraint.activate([
            clockStackView.widthAnchor.constraint(equalToConstant: 28),
        ])
        
        clockStackView.addArrangedSubview(hourLabel)
        
        NSLayoutConstraint.activate([
            hourLabel.heightAnchor.constraint(equalToConstant: 13),
        ])
        
        clockStackView.addArrangedSubview(symbolView)
        
        NSLayoutConstraint.activate([
            symbolView.heightAnchor.constraint(equalToConstant: 27),
        ])
    }
}
