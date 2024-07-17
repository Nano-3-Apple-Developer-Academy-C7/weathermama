//
//  TemperatureView.swift
//  WeatherMama
//
//  Created by Lucky on 16/07/24.
//

import UIKit

class TemperatureView: UIView {
    
    // TEMPERATURE DETAIL
    private lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var temperatureTitleLabel: UIView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        let symbolImageView = UIImageView()
        symbolImageView.image = UIImage(systemName: "thermometer.medium")
        symbolImageView.tintColor = .secondaryLabel
        symbolImageView.contentMode = .scaleAspectFit  // Ensure symbol scales correctly
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "TEMPERATURE"
        titleLabel.font = UIFont(name: "SFProRounded-Regular", size: 12)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(symbolImageView)
        stackView.addArrangedSubview(titleLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var temperatureRateLabel: UILabel = {
        let temperatureRateLabel = UILabel()
        temperatureRateLabel.text = "32°"
        temperatureRateLabel.font = UIFont(name: "SFProRounded-Regular", size: 20)
        temperatureRateLabel.textColor = .black
        temperatureRateLabel.textAlignment = .center
        temperatureRateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return temperatureRateLabel
    }()
    
    func setTemperatureRateLabel(_ text: String) {
        temperatureRateLabel.text = text
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTemperature()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TemperatureView {

    private func setupTemperature() {
        self.translatesAutoresizingMaskIntoConstraints = false 
        
        self.addSubview(temperatureStackView)
        
        NSLayoutConstraint.activate([
            temperatureStackView.widthAnchor.constraint(equalToConstant: 100),
            temperatureStackView.heightAnchor.constraint(equalToConstant: 71),
        ])
        
        temperatureStackView.addArrangedSubview(temperatureTitleLabel)
        
        temperatureStackView.addArrangedSubview(temperatureRateLabel)
    }
}

