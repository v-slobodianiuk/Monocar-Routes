//
//  CollectionViewCell.swift
//  Monocar Routes
//
//  Created by Vadym on 05.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    lazy var mainStackView = UIStackView()
    
    lazy var driverStackView = UIStackView()
    lazy var fullInfoDriverStackView = UIStackView()
    lazy var driverPhoto = UIImageView()
    lazy var driverInfoStackView = UIStackView()
    lazy var driverName = UILabel()
    lazy var driverLicense = UILabel()
    lazy var ratingStackView = UIStackView()
    lazy var starIcon = UIImageView()
    lazy var driverRating = UILabel()
    
    lazy var firstHorizontalLine = UIView()
    lazy var firstInfoStackView = UIStackView()
    
    lazy var timeStackView = UIStackView()
    lazy var timeIcon = UIImageView()
    lazy var timeLabel = UILabel()
    
    lazy var priceStackView = UIStackView()
    lazy var priceIcon = UIImageView()
    lazy var priceLabel = UILabel()
    
    lazy var secondHorizontalLine = UIView()
    lazy var secondInfoStackView = UIStackView()
    
    lazy var dateStackView = UIStackView()
    lazy var dateIcon = UIImageView()
    lazy var dateLabel = UILabel()
    
    lazy var capacityStackView = UIStackView()
    lazy var capacityIcon = UIImageView()
    lazy var capacityLabel = UILabel()
    
    lazy var requestButton = UIButton()
    
    let blueColor = UIColor(red: 0.012, green: 0.506, blue: 0.996, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        
        self.addSubview(mainStackView)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        
        //MARK: DriverStackView
        driverPhoto.contentMode = .scaleAspectFit
        driverPhoto.layer.cornerRadius = 48 / 2
        driverPhoto.layer.masksToBounds = true
        
        mainStackView.addArrangedSubview(driverStackView)
        
        driverStackView.addArrangedSubview(fullInfoDriverStackView)
        fullInfoDriverStackView.alignment = .top
        
        driverStackView.axis = .horizontal
        driverStackView.alignment = .top
        driverStackView.distribution = .equalCentering
        driverStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        driverStackView.isLayoutMarginsRelativeArrangement = true
        
        fullInfoDriverStackView.addArrangedSubview(driverPhoto)
        fullInfoDriverStackView.setCustomSpacing(10, after: driverPhoto)
        fullInfoDriverStackView.addArrangedSubview(driverInfoStackView)
        
        driverStackView.setCustomSpacing(14, after: driverPhoto)
        
        driverInfoStackView.axis = .vertical
        driverInfoStackView.alignment = .fill
        driverInfoStackView.distribution = .fill
        driverInfoStackView.spacing = 0
        driverInfoStackView.addArrangedSubview(driverName)
        driverInfoStackView.addArrangedSubview(driverLicense)
        driverName.text = "Ім'я не вказано"
        driverName.adjustsFontSizeToFitWidth = true
        driverName.font = .systemFont(ofSize: 16, weight: .bold)
        driverLicense.textColor = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        driverLicense.font = .systemFont(ofSize: 14)
        
        driverStackView.addArrangedSubview(ratingStackView)
        ratingStackView.axis = .horizontal
        ratingStackView.alignment = .fill
        ratingStackView.distribution = .fill
        
        ratingStackView.addArrangedSubview(starIcon)
        ratingStackView.addArrangedSubview(driverRating)
        starIcon.image = UIImage(named: "star")
        starIcon.contentMode = .scaleAspectFit
        ratingStackView.setCustomSpacing(6, after: starIcon)
        driverRating.font = .systemFont(ofSize: 12)
        
        mainStackView.addArrangedSubview(firstHorizontalLine)
        
        //MARK: firstInfoStackView
        mainStackView.addArrangedSubview(firstInfoStackView)

        firstHorizontalLine.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        firstInfoStackView.axis = .horizontal
        firstInfoStackView.alignment = .fill
        firstInfoStackView.distribution = .fillEqually
        firstInfoStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        firstInfoStackView.isLayoutMarginsRelativeArrangement = true
        
        firstInfoStackView.addArrangedSubview(timeStackView)
        timeStackView.axis = .horizontal
        timeStackView.spacing = 20
        timeStackView.addArrangedSubview(timeIcon)
        timeIcon.image = UIImage(named: "bx-time-five")
        timeIcon.contentMode = .scaleAspectFit
        timeStackView.addArrangedSubview(timeLabel)
        timeLabel.textColor = blueColor
        timeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        firstInfoStackView.addArrangedSubview(priceStackView)
        priceStackView.axis = .horizontal
        priceStackView.spacing = 20
        priceStackView.addArrangedSubview(priceIcon)
        priceIcon.image = UIImage(named: "bx-money")
        priceIcon.contentMode = .scaleAspectFit
        priceStackView.addArrangedSubview(priceLabel)
        priceLabel.textColor = blueColor
        priceLabel.font = .systemFont(ofSize: 18, weight: .bold)
        priceStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        priceStackView.isLayoutMarginsRelativeArrangement = true
        
        mainStackView.addArrangedSubview(secondHorizontalLine)
        
        //MARK: secondInfoStackView
        mainStackView.addArrangedSubview(secondInfoStackView)
        secondHorizontalLine.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        secondInfoStackView.axis = .horizontal
        secondInfoStackView.alignment = .fill
        secondInfoStackView.distribution = .fillEqually
        secondInfoStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        secondInfoStackView.isLayoutMarginsRelativeArrangement = true
        
        secondInfoStackView.addArrangedSubview(dateStackView)
        dateStackView.axis = .horizontal
        dateStackView.spacing = 20
        dateStackView.addArrangedSubview(dateIcon)
        dateIcon.image = UIImage(named: "bx-calendar")
        dateIcon.contentMode = .scaleAspectFit
        dateStackView.addArrangedSubview(dateLabel)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.font = .systemFont(ofSize: 14)
        
        secondInfoStackView.addArrangedSubview(capacityStackView)
        capacityStackView.axis = .horizontal
        capacityStackView.spacing = 20
        capacityStackView.addArrangedSubview(capacityIcon)
        capacityIcon.image = UIImage(named: "bx-group")
        capacityIcon.contentMode = .scaleAspectFit
        capacityStackView.addArrangedSubview(capacityLabel)
        capacityLabel.font = .systemFont(ofSize: 14)
        capacityStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        capacityStackView.isLayoutMarginsRelativeArrangement = true
        
        //MARK: RequestButton
        requestButton.setTitle("Залишити запит", for: .normal)
        requestButton.backgroundColor = blueColor
        requestButton.layer.cornerRadius = 8
        requestButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        addSubview(requestButton)
    }
    
    private func setupConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            driverPhoto.widthAnchor.constraint(equalToConstant: 48),
            
            firstHorizontalLine.heightAnchor.constraint(equalToConstant: 1),
            secondHorizontalLine.heightAnchor.constraint(equalToConstant: 1),
            
            
            starIcon.widthAnchor.constraint(equalToConstant: 14),
            timeIcon.widthAnchor.constraint(equalToConstant: 20),
            priceIcon.widthAnchor.constraint(equalToConstant: 20),
            dateIcon.widthAnchor.constraint(equalToConstant: 20),
            capacityIcon.widthAnchor.constraint(equalToConstant: 20),
            requestButton.heightAnchor.constraint(equalToConstant: 48),
            
            requestButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            requestButton.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 16),
            requestButton.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant:  -16),
            requestButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
