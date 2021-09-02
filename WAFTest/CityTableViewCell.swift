//
//  CityTableViewCell.swift
//  WAFTest
//
//  Created by baga on 1.09.2021.
//

import SDWebImage
import UIKit

class CityTableViewCell: UITableViewCell {
    var fact: Fact? {
        didSet {
            temp.text = "\((fact!.temp ?? fact!.temp_avg)!)°"
            conditionIcon.sd_setImage(with:
                URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(fact!.icon).svg"),
                completed: nil
            )
        }
    }

    var cityNameLabel: UILabel = {
        var view = UILabel()
        view.textColor = UIColor(red: 1, green: 0.827, blue: 0.412, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        return view
    }()

    let conditionIcon = UIImageView()
    let block = UIView()
    let temp: UILabel = {
        var view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
        setConstraints()
    }

    // MARK: настройка UI

    func setUI() {
        block.layer.cornerRadius = 7
        block.layer.backgroundColor = UIColor(red: 0.224, green: 0.243, blue: 0.275, alpha: 1).cgColor
        block.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.backgroundColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1).cgColor
        cityNameLabel.numberOfLines = 2
        cityNameLabel.lineBreakMode = .byWordWrapping
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        temp.translatesAutoresizingMaskIntoConstraints = false
        conditionIcon.translatesAutoresizingMaskIntoConstraints = false

        addSubview(block)
        block.addSubview(cityNameLabel)
        block.addSubview(conditionIcon)
        block.addSubview(temp)
    }

    // MARK: настройка констрейнтов

    func setConstraints() {
        NSLayoutConstraint.activate([
            block.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            block.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            block.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            block.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -18),
        ])

        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: block.leadingAnchor, constant: 20),
            cityNameLabel.topAnchor.constraint(equalTo: block.topAnchor, constant: 10),
            cityNameLabel.bottomAnchor.constraint(equalTo: block.bottomAnchor, constant: -10),
            temp.trailingAnchor.constraint(equalTo: block.trailingAnchor, constant: -20),
            temp.topAnchor.constraint(equalTo: block.topAnchor, constant: 20),
            temp.bottomAnchor.constraint(equalTo: block.bottomAnchor, constant: -20),
            temp.widthAnchor.constraint(equalToConstant: 75),
            conditionIcon.topAnchor.constraint(equalTo: block.topAnchor, constant: 23),
            conditionIcon.bottomAnchor.constraint(equalTo: block.bottomAnchor, constant: -23),
            conditionIcon.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor),
            conditionIcon.trailingAnchor.constraint(equalTo: temp.leadingAnchor),
            conditionIcon.widthAnchor.constraint(equalToConstant: 55),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
