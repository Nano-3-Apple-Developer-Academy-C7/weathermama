//
//  WindView.swift
//  WeatherMama
//
//  Created by Lucky on 16/07/24.
//

import UIKit

class WindView: UIView {
    
    // WIND DETAIL
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var windTitleLabel: UIView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        let symbolImageView = UIImageView()
        symbolImageView.image = UIImage(systemName: "wind")
        symbolImageView.tintColor = .secondaryLabel
        symbolImageView.contentMode = .scaleAspectFit  // Ensure symbol scales correctly
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "WIND"
        titleLabel.font = UIFont(name: "SFProRounded-Regular", size: 12)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(symbolImageView)
        stackView.addArrangedSubview(titleLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var windRateLabel: UILabel = {
        let windRateLabel = UILabel()
        windRateLabel.text = "119 km/h"
        windRateLabel.font = UIFont(name: "SFProRounded-Regular", size: 20)
        windRateLabel.textColor = .black
        windRateLabel.textAlignment = .center
        windRateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return windRateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupWindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension WindView {

    private func setupWindView() {
        self.translatesAutoresizingMaskIntoConstraints = false 
        
        self.addSubview(windStackView)
        
        NSLayoutConstraint.activate([
            windStackView.widthAnchor.constraint(equalToConstant: 100),
            windStackView.heightAnchor.constraint(equalToConstant: 71),
        ])
        
        windStackView.addArrangedSubview(windTitleLabel)
        
        windStackView.addArrangedSubview(windRateLabel)
    }
}
