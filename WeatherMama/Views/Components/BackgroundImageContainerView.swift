//
//  BackgroundImageContainerView.swift
//  WeatherMama
//
//  Created by Lucky on 13/07/24.
//

import UIKit

class BackgroundImageContainerView: UIView {
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImage(named: "bright")
        let backgroundImageView = UIImageView(image: backgroundImage)
        
        backgroundImageView.contentMode = .scaleToFill
        self.addSubview(backgroundImageView)
        self.sendSubviewToBack(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return backgroundImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackgroundImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackgroundImage(image: UIImage?) {
        backgroundImage.image = image
    }
}

private extension BackgroundImageContainerView {    
    private func setupBackgroundImage() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
