//
//  DetailViewController.swift
//  WAFTest
//
//  Created by baga on 01.09.2021.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var detailItem: City?
    var tableView = UITableView()
    let parts = ["morning", "day", "evening", "night"]
    let ru_parts = ["утро", "день", "вечер", "ночь"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        configureTableView()
        setCityLabel()
        
    }
    //MARK: Конфигурация TableView
    func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: UITableView.Style.grouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "part")
        tableView.backgroundColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        view.addSubview(tableView)
    }
    
    //MARK: Лейбл с названием города в tableHeaderView
    func setCityLabel() {
        let label = UILabel()
        let tableHeaderView = UIView()
        label.frame = CGRect(x: 16, y: 0, width: self.view.frame.width - 116, height: 30)
        label.textColor = UIColor(red: 1, green: 0.827, blue: 0.412, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        label.text = detailItem?.name
        
        tableHeaderView.addSubview(label)
        tableView.tableHeaderView = tableHeaderView
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        var day = "Сегодня"
        if section == 1 {
            day = "Завтра"
        }
        let label = UILabel()
        let headerView = UIView()
        label.frame = CGRect(x: self.view.frame.width - 116, y: 0, width: 100, height: 30)
        label.textColor = UIColor(red: 1, green: 0.827, blue: 0.412, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.thin)
        label.text = day
        label.textAlignment = .right
        
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "part", for: indexPath) as! CityTableViewCell
        
        cell.fact = detailItem?.forecasts[indexPath.section].parts[self.parts[indexPath.row]]
        cell.cityNameLabel.text = self.ru_parts[indexPath.row]
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 137.0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
