//
//  AddCityViewController.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import UIKit

protocol AddCitytDisplayLogic: AnyObject {
    func displayCityList(viewModel: FetchCityList.ViewModel)
}

class AddCityViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: Properties
    var interactor: CityListBusinessLogic?
    var router: CityListRouting?
    var cityList: [DisplayedCityListProtocol]?
    var filtredCityList: [DisplayedCityListProtocol]?
    var city: CityProtocol?
    var isSearching = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Constants.Strings.dataNeedsRefresh, object: nil)
    }
    
    // MARK: SetUp View
    private func setUpView() {
        setUpButtons()
        setUpSearchBar()
        setUpTableView()
        startActivityIndicator()
        interactor?.getCityList()
    }
    
    private func setUpButtons() {
        addButton.isHidden = true
        addButton.addTarget(self, action: #selector(addAction(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: Constants.Strings.cityListTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Strings.cityListTableViewCell)
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    @objc func addAction(_ sender: UIButton) {
        guard let city = city else {
            router?.dismissViewController(fromCanel: false)
            return
        }
        interactor?.addSelectedCity(model: city)
        router?.dismissViewController(fromCanel: false)
    }
    
    @objc func cancelAction(_ sender: UIButton) {
        router?.dismissViewController(fromCanel: true)
    }
    
    
}

// MARK: SearchBar delegate
extension AddCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            isSearching = true
            filtredCityList = cityList?.filter({ $0.cityName.string.contains(searchText) })
        } else {
            isSearching = false
        }
        tableView.reloadData()
    }
}

// MARK: TableViewDelegate && TableViewDataSource
extension AddCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filtredCityList?.count ?? 0 : cityList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Strings.cityListTableViewCell, for: indexPath) as! CityListTableViewCell
        cell.config(viewModel: isSearching ? filtredCityList?[indexPath.row] : cityList?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // Find any selected row in this section
        if let selectedIndexPath = tableView.indexPathsForSelectedRows?.first(where: {
            $0.section == indexPath.section
        }) {
            // Deselect the row
            tableView.deselectRow(at: selectedIndexPath, animated: false)
            // deselectRow doesn't fire the delegate method so need to
            // unset the checkmark here
            tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
        }
        return indexPath
    }

    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        // Prevent deselection of a cell
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        addButton.isHidden = false
        city = isSearching ? filtredCityList?[indexPath.row].model : cityList?[indexPath.row].model
    }
}

// MARK: AddCitytDisplayLogic
extension AddCityViewController: AddCitytDisplayLogic {
    
    func displayCityList(viewModel: FetchCityList.ViewModel) {
        stopActivityIndicator()
        cityList = viewModel.displayedCityList
        tableView.reloadData()
    }
}
