//
//  MeteoDetailViewController.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import UIKit

protocol MeteoDetailDisplayLogic: AnyObject {
    func displayMeteoDetail(viewModel: FetchWeather.ViewModel)
}

class MeteoDetailViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var currentlyWeatherView: UIView!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var dailyStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var interactor: MeteoDetailBusinessLogic?
    var router: MeteoDetailRouting?
    var weatherDetail: DisplayedWeathertProtocol?
    lazy var currentlyView: CurrentlyWeatherView = {
        let currentlyView = CurrentlyWeatherView.fromNib()
        return currentlyView
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
       interactor?.getWeather()
    }
    
    // MARK: SetUp View
    private func setUpView() {
        setUpGradient()
        startActivityIndicator()
        setUpCurrentlyWeatherView()
        setUpHourlyCollectionView()
        setUpDailyStackView()
    }
    
    private func setUpGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Constants.Colors.gradientAPP
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setUpCurrentlyWeatherView() {
        currentlyWeatherView.addSubview(currentlyView)
    }
    
    private func setUpHourlyCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = .leastNormalMagnitude
        layout.minimumLineSpacing = .leastNormalMagnitude
        hourlyCollectionView.collectionViewLayout = layout
        hourlyCollectionView.showsVerticalScrollIndicator = false
        hourlyCollectionView.showsHorizontalScrollIndicator = false
        hourlyCollectionView.isPagingEnabled = true
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.register(UINib(nibName: Constants.Strings.hourlyCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.Strings.hourlyCollectionViewCell)
    }
    
    private func setUpDailyStackView() {
        dailyStackView.spacing = 2
        dailyStackView .distribution = .fillEqually
    }
    
    private func addArrangedSubView(daily: [DisplayedDaily]) {
        daily.forEach({ day in
            let dailyView = DailyView.fromNib()
            dailyView.config(viewModel: day)
            dailyStackView.addArrangedSubview(dailyView)
        })
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

// MARK: CollectionViewDelegate && CollectionViewDataSource && CollectionViewDelegateFlowLayout
extension MeteoDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDetail?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Strings.hourlyCollectionViewCell,
                                                         for: indexPath) as? HourlyCollectionViewCell {
            if let displayedHourly = weatherDetail?.hourly {
                cell.config(viewModel: displayedHourly[indexPath.item])
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
}


// MARK: MeteoDetailDisplayLogic
extension MeteoDetailViewController: MeteoDetailDisplayLogic {
    func displayMeteoDetail(viewModel: FetchWeather.ViewModel) {
        weatherDetail = viewModel.displayedWeatherDetail
        guard let current = weatherDetail?.current, let daily = weatherDetail?.daily else { return }
        currentlyView.config(viewModel: current)
        stopActivityIndicator()
        hourlyCollectionView.reloadData()
        addArrangedSubView(daily: daily)
    }
}
