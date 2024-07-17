//
//  MainViewController.swift
//  WeatherMama
//
//  Created by Lucky on 13/07/24.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {
    // SCROLL VIEW
    
    let weatherFetcher = WeatherFetcher()
    let locationManager = CLLocationManager()
    
    var recommendationTimes: [PotentialWindow] = []
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        self.view.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // OTHER VIEW
    private lazy var backgroundImageContainerView: BackgroundImageContainerView = {
        let view = BackgroundImageContainerView()
        return view
    }()
    
    lazy var topContainerView: TopContainerView = {
        let view = TopContainerView()
        return view
    }()
    
    lazy var centerContainerView: CenterContainerView = {
        let view = CenterContainerView()
        return view
    }()
    
    lazy var mainBoxContainerView: MainBoxContainerView = {
        let view = MainBoxContainerView()
        return view
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        setupMainView()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    func fetchWeatherData() {
        guard let location = locationManager.location else {
            topContainerView.setRecomendationLabel("Unable to fetch location")
            print("GAGAL COK")
            return
        }
        print("BERHASIL")
        fetchWeather(for: location)
    }
}

private extension MainViewController {
    
    private func setupMainView() {
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        contentView.addSubview(backgroundImageContainerView)
        
        NSLayoutConstraint.activate([
            backgroundImageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        contentView.addSubview(topContainerView)
        
        NSLayoutConstraint.activate([
            // 122
            topContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            topContainerView.topAnchor.constraint(equalTo: backgroundImageContainerView.topAnchor, constant: 108),
        ])
        
        contentView.addSubview(centerContainerView)
        
        NSLayoutConstraint.activate([
            // 258
            centerContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            centerContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 273),
        ])
        
        contentView.addSubview(mainBoxContainerView)
        
        NSLayoutConstraint.activate([
            mainBoxContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            mainBoxContainerView.topAnchor.constraint(equalTo: centerContainerView.bottomAnchor, constant: 48),
            mainBoxContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35),
        ])
    }
}


// PREVIEW
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        //
    }
    
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
}
#endif

struct BestInClassPreviews_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = MainViewController() 
            return vc
        }
    }
}
