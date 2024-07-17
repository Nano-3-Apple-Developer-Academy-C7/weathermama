//
//  MainBoxContainerView.swift
//  WeatherMama
//
//  Created by Lucky on 13/07/24.
//

import UIKit

class MainBoxContainerView: UIView {
    
    private var currentHour: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.clockGridContainerView.reloadData()
            }
        }
    }
    
    var hourlyWeatherData: [HourlyWeatherData] = []
    var indexHour = -1
    
    private lazy var clockGridContainerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 29
        layout.itemSize = .init(width: 28, height: 101)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.register(ClockCollectionViewCell.self, forCellWithReuseIdentifier: "ClockCollectionViewCell")
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var twhStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 1.5
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("HOURLY FORECAST", comment: "HOURLY FORECAST")
        titleLabel.font = UIFont(name: "SFProRounded-Regular", size: 12)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var secondTitleLabel: UILabel = {
        let secondTitleLabel = UILabel()
        secondTitleLabel.text = NSLocalizedString("AT THIS HOUR", comment: "AT THIS HOUR")
        secondTitleLabel.font = UIFont(name: "SFProRounded-Regular", size: 12)
        secondTitleLabel.textColor = .secondaryLabel
        secondTitleLabel.textAlignment = .left
        secondTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return secondTitleLabel
    }()
    
    private lazy var firstLineView: UIView = {
        let firstLineView = UIView()
        firstLineView.backgroundColor = .opaqueSeparator
        firstLineView.layer.cornerRadius = 1
        firstLineView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstLineView
    }()
    
    private lazy var secondLineView: UIView = {
        let secondLineView = UIView()
        secondLineView.backgroundColor = .opaqueSeparator
        secondLineView.layer.cornerRadius = 1
        secondLineView.translatesAutoresizingMaskIntoConstraints = false
        
        return secondLineView
    }()
    
    private lazy var thirdLineView: UIView = {
        let thirdLineView = UIView()
        thirdLineView.backgroundColor = .opaqueSeparator
        thirdLineView.layer.cornerRadius = 1
        thirdLineView.translatesAutoresizingMaskIntoConstraints = false
        
        return thirdLineView
    }()
    
    private lazy var firstVerticalLineView: UIView = {
        let firstVerticalLineView = UIView()
        firstVerticalLineView.backgroundColor = .opaqueSeparator
        firstVerticalLineView.layer.cornerRadius = 1
        firstVerticalLineView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstVerticalLineView
    }()
    
    private lazy var secondVerticalLineView: UIView = {
        let secondVerticalLineView = UIView()
        secondVerticalLineView.backgroundColor = .opaqueSeparator
        secondVerticalLineView.layer.cornerRadius = 1
        secondVerticalLineView.translatesAutoresizingMaskIntoConstraints = false
        
        return secondVerticalLineView
    }()
    
    private lazy var clockWithSymbolView: ClockWithSymbolView = {
        let view = ClockWithSymbolView()
        return view
    }()
    
    lazy var precipitationView: PrecipitationView = {
        let view = PrecipitationView()
        return view
    }()
    
    lazy var temperatureView: TemperatureView = {
        let view = TemperatureView()
        return view
    }()
    
    lazy var windView: WindView = {
        let view = WindView()
        return view
    }()
    
    lazy var humidityView: HumidityView = {
        let view = HumidityView()
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMainBox()
        setCurrentHour()
        scrollToCurrentHour()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainBoxContainerView {
    private func setCurrentHour() {
        // Implement logic to set currentHour
        let calendar = Calendar.current
        currentHour = calendar.component(.hour, from: Date())
        
        // Adjust currentHour if necessary
        if currentHour == 0 {
            currentHour = 24
        }
    }
    
    private func scrollToCurrentHour() {
        let indexPath = IndexPath(item: currentHour - 1, section: 0)
        
        DispatchQueue.main.async {
            self.clockGridContainerView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            self.clockGridContainerView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            
            if let cell = self.clockGridContainerView.cellForItem(at: indexPath) as? ClockCollectionViewCell {
                cell.isSelected = true
            }
        }
    }
    
    private func setupMainBox() {
        self.backgroundColor = UIColor.wmBoxColors
        self.layer.cornerRadius = 20
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 344),
            self.heightAnchor.constraint(equalToConstant: 418),
        ])
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 14),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -214)
        ])
        
        self.addSubview(firstLineView)
        
        NSLayoutConstraint.activate([
            firstLineView.heightAnchor.constraint(equalToConstant: 1),
            
            firstLineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            firstLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            firstLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        // TIME
        self.addSubview(clockGridContainerView)
        
        NSLayoutConstraint.activate([
            clockGridContainerView.heightAnchor.constraint(equalToConstant: 102),
            
            clockGridContainerView.topAnchor.constraint(equalTo: firstLineView.bottomAnchor, constant: 20),
            clockGridContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            clockGridContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        self.addSubview(secondTitleLabel)
        
        NSLayoutConstraint.activate([
            secondTitleLabel.heightAnchor.constraint(equalToConstant: 14),
            
            secondTitleLabel.topAnchor.constraint(equalTo: clockGridContainerView.bottomAnchor, constant: 29),
            secondTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            secondTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -244)
        ])
        
        self.addSubview(secondLineView)
        
        NSLayoutConstraint.activate([
            secondLineView.heightAnchor.constraint(equalToConstant: 1),
            
            secondLineView.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 4),
            secondLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            secondLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        self.addSubview(precipitationView)
        
        NSLayoutConstraint.activate([
            precipitationView.heightAnchor.constraint(equalToConstant: 33),
            
            precipitationView.topAnchor.constraint(equalTo: secondLineView.bottomAnchor, constant: 30),
            precipitationView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            precipitationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
        ])
        
        self.addSubview(thirdLineView)
        
        NSLayoutConstraint.activate([
            thirdLineView.heightAnchor.constraint(equalToConstant: 1),
            
            thirdLineView.topAnchor.constraint(equalTo: precipitationView.bottomAnchor, constant: 30),
            thirdLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            thirdLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        self.addSubview(twhStackView)
        
        NSLayoutConstraint.activate([
            twhStackView.heightAnchor.constraint(equalToConstant: 87),
            
            twhStackView.topAnchor.constraint(equalTo: thirdLineView.bottomAnchor, constant: 10),
            twhStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            twhStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
        ])
        
        twhStackView.addArrangedSubview(temperatureView)
        
        NSLayoutConstraint.activate([
            temperatureView.widthAnchor.constraint(equalToConstant: 100),
            temperatureView.heightAnchor.constraint(equalToConstant: 71),
        ])
        
        twhStackView.addArrangedSubview(firstVerticalLineView)
        
        NSLayoutConstraint.activate([
            firstVerticalLineView.widthAnchor.constraint(equalToConstant: 1),
            firstVerticalLineView.heightAnchor.constraint(equalToConstant: 87),
        ])
        
        twhStackView.addArrangedSubview(windView)
        
        NSLayoutConstraint.activate([
            windView.heightAnchor.constraint(equalToConstant: 71),
        ])
        
        twhStackView.addArrangedSubview(secondVerticalLineView)
        
        NSLayoutConstraint.activate([
            secondVerticalLineView.widthAnchor.constraint(equalToConstant: 1),
            secondVerticalLineView.heightAnchor.constraint(equalToConstant: 87),
        ])
        
        twhStackView.addArrangedSubview(humidityView)
        
        NSLayoutConstraint.activate([
            humidityView.widthAnchor.constraint(equalToConstant: 100),
            humidityView.heightAnchor.constraint(equalToConstant: 71),
        ])
    }
}


extension MainBoxContainerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClockCollectionViewCell", for: indexPath) as! ClockCollectionViewCell
        
        let hour = indexPath.item
        
        cell.clockView?.setHour(hour + 1)

        // Change color if the hour is less than the current hour
        let calendar = Calendar.current
        
        let currentHour = calendar.component(.hour, from: Date())
        
        if hour < currentHour - 1 {
            cell.clockView?.setHourColor(.gray)
            cell.clockView?.setSymbolColor(.gray)
            cell.isUserInteractionEnabled = false
        } else {
            cell.clockView?.setHourColor(.black)
            cell.clockView?.setSymbolColor(.systemOrange)
            cell.isUserInteractionEnabled = true
        }
        
        return cell
    }
}

extension MainBoxContainerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let calendar = Calendar.current
        
        let currentHour = calendar.component(.hour, from: Date())
        
        if indexPath.item < currentHour - 1 {
            return // Ignore selection if the hour is less than the current hour
        }
        
        // Handle cell selection here
        print("Selected hour:", indexPath.item + 1)
        
        indexHour = indexPath.item
        
        DispatchQueue.main.async {
            self.humidityView.setHumidityRateLabel("\(self.hourlyWeatherData[indexPath.item].humidity * 100) %")
            self.windView.setWindRateLabel("\(self.hourlyWeatherData[indexPath.item].windSpeed) Km/H")
            self.temperatureView.setTemperatureRateLabel("\(self.hourlyWeatherData[indexPath.item].temperature) °")
            self.precipitationView.setPrecipitationRateLabel("\(self.hourlyWeatherData[indexPath.item].precipitationChance * 100) %")
            self.precipitationView.setPrecipitationStatusLabel("\(self.hourlyWeatherData[indexPath.item].precipitationCategory())")
        }
        
        // Update the appearance of the selected cell
        if let cell = collectionView.cellForItem(at: indexPath) as? ClockCollectionViewCell {
            cell.isSelected = true // This will trigger the cell's selection state update
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Deselect if needed
        if let cell = collectionView.cellForItem(at: indexPath) as? ClockCollectionViewCell {
            cell.isSelected = false
        }
    }
}
