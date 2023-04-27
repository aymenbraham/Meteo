//
//  MeteoListViewController.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import UIKit

protocol MeteoListDisplayLogic: AnyObject {
    func displayMeteoCityList(viewModel: FetchMeteoCityList.ViewModel)
    func displayError(error: ModelError)
}

class MeteoListViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var interactor: MeteoListBusinessLogic?
    var router: MeteoListRouting?
    var meteoCityList: [DisplayedMeteoCityListProtocol]?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        interactor?.getCitiesList()
        addObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refrechData),
                                               name: Constants.Strings.dataNeedsRefresh,
                                               object: nil)
    }
    
    @objc func refrechData() {
        interactor?.getCitiesList()
    }
    
    // MARK: SetUp View
    private func setUpView() {
        setUpNavBar()
        setUpTableView()
        startActivityIndicator()
    }
    
    private func setUpNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add", style: .done, target: self, action: #selector(self.addAction(sender:)))
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: Constants.Strings.meteoListTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Strings.meteoListTableViewCell)
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    @objc func addAction(sender: UIBarButtonItem) {
        router?.goToAddCity()
    }

}

// MARK: TableViewDelegate && TableViewDataSource
extension MeteoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteoCityList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Strings.meteoListTableViewCell, for: indexPath) as! MeteoListTableViewCell
        cell.config(viewModel: meteoCityList?[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weather = meteoCityList?[indexPath.row].model else { return }
        router?.goToMeteoDetail(model: weather)
    }
}

// MARK: MeteoListDisplayLogic
extension MeteoListViewController: MeteoListDisplayLogic {
    func displayMeteoCityList(viewModel: FetchMeteoCityList.ViewModel) {
        meteoCityList = viewModel.displayedMeteoCityList
        stopActivityIndicator()
        tableView.reloadData()
    }
    
    func displayError(error: ModelError) {
        stopActivityIndicator()
        let alertController = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in }
        alertController.addAction(okAction)
        self.present(alertController, animated: false)
    }
}
