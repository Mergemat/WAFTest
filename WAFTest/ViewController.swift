//
//  ViewController.swift
//  WAFTest
//
//  Created by baga on 1.09.2021.
//

import Alamofire
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var tableView = UITableView()
    var searchController = UISearchController()

    var cities = [City]()
    var searchedCity = [City]()
    var citiesData = [
        ["city": "Москва", "lat": 55.75396, "lon": 37.620393],
        ["city": "Нижний Новгород", "lat": 56.3286700, "lon": 44.0020500],
        ["city": "Новосибирск", "lat": 55.028739, "lon": 82.90692799999999],
        ["city": "Екатеринбург", "lat": 56.838002, "lon": 60.597295],
        ["city": "Казань", "lat": 55.795793, "lon": 49.106585],
        ["city": "Самара", "lat": 53.195533, "lon": 50.101801],
        ["city": "Омск", "lat": 54.989342, "lon": 73.368212],
        ["city": "Ростов-на-Дону", "lat": 47.227151, "lon": 39.744972],
        ["city": "Уфа", "lat": 54.734768, "lon": 55.957838],
        ["city": "Пермь", "lat": 58.004785, "lon": 56.237654],
    ]
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setTableViewAndSearch()
        setUI()
        view.addSubview(tableView)
    }

    // MARK: Настройка UI

    func setUI() {
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.backgroundColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        view.backgroundColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        tableView.backgroundColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
    }

    // MARK: Конфигурация TableView и SearchBar

    func setTableViewAndSearch() {
        searchController = UISearchController(searchResultsController: nil)
        tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        definesPresentationContext = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "city")
        tableView.tableHeaderView = searchController.searchBar
    }

    // MARK: Получаем данные с API Яндекс Погоды

    func getData() {
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": "a07fb4e6-55ba-4ca3-9b35-e6f35189e98e",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        for cityData in citiesData {
            AF.request("https://api.weather.yandex.ru/v2/forecast",
                       method: .get,
                       parameters: ["lat": cityData["lat"]!, "lon": cityData["lon"]!, "lang": "ru_RU", "limit": 2, "hours": false, "extra": false],
                       headers: headers).response { response in

                switch response.result {
                case .success:
                    var city = try! JSONDecoder().decode(City.self, from: response.data!)
                    city.name = cityData["city"] as? String
                    self.cities.append(city)
                    self.tableView.reloadData()

                case let .failure(error):
                    print(error)
                    let alert = UIAlertController(title: "Ошибочка", message: "Отсутствует подключение с сервером", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Понятно", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedCity.count
        } else {
            return cities.count
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as! CityTableViewCell
        if isSearching {
            cell.fact = searchedCity[indexPath.row].fact
            cell.cityNameLabel.text = searchedCity[indexPath.row].name
        } else {
            cell.fact = cities[indexPath.row].fact
            cell.cityNameLabel.text = cities[indexPath.row].name
        }

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 137.0
    }

    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        searchedCity = cities.filter { $0.name!.lowercased().prefix(searchText.count) == searchText.lowercased() }
        isSearching = true
        tableView.reloadData()
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = DetailViewController()
        controller.detailItem = cities[indexPath.row]
        present(controller, animated: true, completion: nil)
    }
}
