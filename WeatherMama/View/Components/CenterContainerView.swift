//
//  CenterContainerView.swift
//  WeatherMama
//
//  Created by Lucky on 13/07/24.
//

import UIKit

class CenterContainerView: UIView {
    private lazy var centerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var bestLaundryTLabel: UILabel = {
        let bestLaundryTLabel = UILabel()
        bestLaundryTLabel.text = "BEST TIME:"
        bestLaundryTLabel.textColor = .secondaryLabel
        bestLaundryTLabel.font = UIFont(name: "SFProRounded-Regular", size: 16)
        bestLaundryTLabel.textAlignment = .center
        bestLaundryTLabel.translatesAutoresizingMaskIntoConstraints = false 
        
        return bestLaundryTLabel
    }()
    
    private lazy var bestTimeLabel: UILabel = {
        let bestTimeLabel = UILabel()
        bestTimeLabel.text = "08.00"
        bestTimeLabel.textColor = .black
        bestTimeLabel.font = UIFont(name: "SFProRounded-Regular", size: 48)
        bestTimeLabel.textAlignment = .center
        bestTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return bestTimeLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "OPTIMAL CONDITIONS FOR QUICK DRYING!"
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.font = UIFont(name: "SFProRounded-Regular", size: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return descriptionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCenterContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CenterContainerView {
    private func setupCenterContainer() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(centerStackView)
        
        centerStackView.addArrangedSubview(bestLaundryTLabel)
        centerStackView.addArrangedSubview(bestTimeLabel)
        centerStackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 204),
            
            centerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            centerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            centerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            centerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
} 
