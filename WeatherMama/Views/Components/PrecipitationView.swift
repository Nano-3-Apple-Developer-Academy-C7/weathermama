//
//  PrecipitationView.swift
//  WeatherMama
//
//  Created by Lucky on 15/07/24.
//

import UIKit

class PrecipitationView: UIView {
    
    // PRECIPITATION DETAIL
    private lazy var precipitationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var precipitationTitleLabel: UIView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
        let symbolImageView = UIImageView()
        symbolImageView.image = UIImage(systemName: "umbrella.fill")
        symbolImageView.tintColor = .secondaryLabel
        symbolImageView.contentMode = .scaleAspectFit  // Ensure symbol scales correctly
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("PRECIPITATION", comment: "PRECIPITATION")
        titleLabel.font = UIFont(name: "SFProRounded-Regular", size: 12)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(symbolImageView)
        stackView.addArrangedSubview(titleLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var precipitationRateLabel: UILabel = {
        let precipitationRateLabel = UILabel()
        precipitationRateLabel.text = "15%"
        precipitationRateLabel.font = UIFont(name: "SFProRounded-Regular", size: 20)
        precipitationRateLabel.textColor = .black
        precipitationRateLabel.textAlignment = .center
        precipitationRateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return precipitationRateLabel
    }()
    
    private lazy var precipitationStatusLabel: UILabel = {
        let precipitationStatusLabel = UILabel()
        precipitationStatusLabel.text = NSLocalizedString("Low", comment: "Low")
        precipitationStatusLabel.font = UIFont(name: "SFProRounded-Regular", size: 20)
        precipitationStatusLabel.textColor = .systemMint
        precipitationStatusLabel.textAlignment = .center
        precipitationStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return precipitationStatusLabel
    }()
    
    func setPrecipitationRateLabel(_ text: String) {
        precipitationRateLabel.text = text
    }
    
    func setPrecipitationStatusLabel(_ text: String) {
        precipitationStatusLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPrecipitation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PrecipitationView {
    
    private func setupPrecipitation() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(precipitationStackView)
        
        NSLayoutConstraint.activate([
            precipitationStackView.heightAnchor.constraint(equalToConstant: 33),
            
            precipitationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            precipitationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        precipitationStackView.addArrangedSubview(precipitationTitleLabel)
        
        NSLayoutConstraint.activate([
            precipitationTitleLabel.widthAnchor.constraint(equalToConstant: 103),
            
            precipitationTitleLabel.topAnchor.constraint(equalTo: precipitationStackView.topAnchor),
            precipitationTitleLabel.bottomAnchor.constraint(equalTo: precipitationStackView.bottomAnchor),
        ])
        
        precipitationStackView.addArrangedSubview(precipitationRateLabel)
        
        NSLayoutConstraint.activate([
            precipitationRateLabel.topAnchor.constraint(equalTo: precipitationStackView.topAnchor),
            precipitationRateLabel.bottomAnchor.constraint(equalTo: precipitationStackView.bottomAnchor),
        ])
        
        precipitationStackView.addArrangedSubview(precipitationStatusLabel)
        
        NSLayoutConstraint.activate([
            precipitationStatusLabel.widthAnchor.constraint(equalToConstant: 103),
            
            precipitationStatusLabel.topAnchor.constraint(equalTo: precipitationStackView.topAnchor),
            precipitationStatusLabel.bottomAnchor.constraint(equalTo: precipitationStackView.bottomAnchor),
        ])
    }
    
}
