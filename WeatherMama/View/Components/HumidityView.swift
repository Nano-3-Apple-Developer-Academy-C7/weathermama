//
//  HumidityView.swift
//  WeatherMama
//
//  Created by Lucky on 16/07/24.
//

import UIKit

class HumidityView: UIView {

    // HUMIDITY DETAIL
    private lazy var humidityView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var humidityTitleLabel: UIView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        let symbolImageView = UIImageView()
        symbolImageView.image = UIImage(systemName: "humidity.fill")
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
    
    private lazy var humidityRateLabel: UILabel = {
        let humidityRateLabel = UILabel()
        humidityRateLabel.text = "35%"
        humidityRateLabel.font = UIFont(name: "SFProRounded-Regular", size: 20)
        humidityRateLabel.textColor = .black
        humidityRateLabel.textAlignment = .center
        humidityRateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return humidityRateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHumidityView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HumidityView {

    private func setupHumidityView() {
        self.translatesAutoresizingMaskIntoConstraints = false 
        
        self.addSubview(humidityView)
        
        NSLayoutConstraint.activate([
            humidityView.widthAnchor.constraint(equalToConstant: 100),
            humidityView.heightAnchor.constraint(equalToConstant: 71),
        ])
        
        humidityView.addArrangedSubview(humidityTitleLabel)
        
        humidityView.addArrangedSubview(humidityRateLabel)
    }
}
