//
//  TopContainerView.swift
//  WeatherMama
//
//  Created by Lucky on 13/07/24.
//

import UIKit

class TopContainerView: UIView {
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private lazy var todayLabel: UILabel = {
        let todayLabel = UILabel()
        todayLabel.text = "TODAY"
        todayLabel.textColor = .black
        todayLabel.font = UIFont(name: "SFProRounded-Bold", size: 20.0)
        todayLabel.textAlignment = .center
        todayLabel.translatesAutoresizingMaskIntoConstraints = false 
        
        return todayLabel
    }()
    
    private lazy var recomendationLabel: UILabel = {
        let recomendationLabel = UILabel()
        recomendationLabel.text = "Perfect day to dry your clothes!"
        recomendationLabel.textColor = .black
        recomendationLabel.font = UIFont(name: "SFProRounded-Regular", size: 32.0)
        recomendationLabel.numberOfLines = 0
        recomendationLabel.textAlignment = .center
        recomendationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return recomendationLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTopContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRecomendationLabel(_ text: String) {
        recomendationLabel.text = text
    }
}

private extension TopContainerView {
    private func setupTopContainer() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(topStackView)
        
        topStackView.addArrangedSubview(todayLabel)
        topStackView.addArrangedSubview(recomendationLabel)
        
        NSLayoutConstraint.activate([
            todayLabel.heightAnchor.constraint(equalToConstant: 24),
            
            self.widthAnchor.constraint(equalToConstant: 293),
            
            topStackView.topAnchor.constraint(equalTo: self.topAnchor),
            topStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
