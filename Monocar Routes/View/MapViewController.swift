//
//  MapViewController.swift
//  Monocar Routes
//
//  Created by Vadym on 05.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import UIKit
import GoogleMaps
import SDWebImage

class MapViewController: UIViewController {
    
    var presenter: MapPresenterProtocol!
    private lazy var mapView = GMSMapView()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        presenter.getData()
        
        self.title = "Знайдено (Х)"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        mapView.frame = self.view.frame
        self.view.addSubview(mapView)
        
        setupCollectionView()
        
//        let camera = GMSCameraPosition.camera(withLatitude: 50.44489, longitude: 30.441591, zoom: 14.0)
//        mapView.camera = camera
    }
}

// MARK: - Map
extension MapViewController {
    private func setupFullPolyline(stringPath: String) {
        let path = GMSPath(fromEncodedPath: stringPath)
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4
        
        let greenColor = UIColor(red: 0, green: 0.8, blue: 0.2, alpha: 1)
        
        let styles = [GMSStrokeStyle.solidColor(greenColor), GMSStrokeStyle.solidColor(UIColor.clear)]
        let lengths: [NSNumber] = [15,8]
        polyline.spans = GMSStyleSpans(path!, styles, lengths, GMSLengthKind.geodesic)
        polyline.geodesic = true
        polyline.map = mapView
        
        let bounds = GMSCoordinateBounds(path: path!)
        
        DispatchQueue.main.async {
            self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
        }
    }
    
    private func setupRoutePolyline(stringPath: String) {
        let path = GMSPath(fromEncodedPath: stringPath)
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = UIColor(red: 0.012, green: 0.506, blue: 0.996, alpha: 1)
        polyline.strokeWidth = 4
        polyline.geodesic = true
        polyline.map = mapView
    }
    
    private func addMarker(iconName: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let icon = UIImage(named: iconName)
        let markerView = UIImageView(image: icon)
        marker.iconView = markerView
        marker.map = mapView
    }
    
    private func setupDots(at index: Int) {
        DispatchQueue.main.async {
            if let passangerData = self.presenter.passangerModel {
                self.setupFullPolyline(stringPath: passangerData.route.polyline)
                self.addMarker(iconName: "Gray Ellipse", latitude: passangerData.start.geo.latitude, longitude: passangerData.start.geo.longitude)
                self.addMarker(iconName: "Gray Ellipse", latitude: passangerData.end.geo.latitude, longitude: passangerData.end.geo.longitude)
            }
            
            if let driverData = self.presenter.driversModel?.result[index] {
                self.setupRoutePolyline(stringPath: driverData.route_main)
                self.addMarker(iconName: "Start marker", latitude: driverData.point_pickup.latitude, longitude: driverData.point_pickup.longitude)
                self.addMarker(iconName: "End marker", latitude: driverData.point_dropoff.latitude, longitude: driverData.point_dropoff.longitude)
            }
        }
    }
}

// MARK: - CollectionView
extension MapViewController {
    func setupCollectionView() {
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "DriverCard")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        switch UIScreen.main.bounds.maxY {
        case 0..<812:
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15).isActive = true
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        default:
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        }
        
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.collectionViewLayout = CustomCollectionViewLayout()
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
        layout.scrollDirection = .horizontal
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

// MARK: UICollectionViewDataSource
extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.driversCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let driverCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DriverCard", for: indexPath) as! CollectionViewCell
        
        guard let driverData = presenter.driversModel?.result[indexPath.row] else { return driverCell }
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 48, height: 48), scaleMode: .aspectFit)
        
        if let pictureUrl = URL(string: driverData.picture_url) {
            driverCell.driverPhoto.sd_setImage(with: pictureUrl, placeholderImage: nil, context: [.imageTransformer: transformer])
        }
        if !driverData.name.isEmpty {
            driverCell.driverName.text = driverData.name
        }
        
        if driverData.is_driver {
            driverCell.driverLicense.text = "(Водій)"
        }
        driverCell.driverRating.text = String(driverData.rating)
        driverCell.timeLabel.text = presenter.getDate()[indexPath.row].1
        driverCell.priceLabel.text = String(driverData.cost_per_seat)
        driverCell.dateLabel.text = presenter.getDate()[indexPath.row].0
        driverCell.capacityLabel.text = String(driverData.seats_count)
        
        return driverCell
    }
}

// MARK: UICollectionViewDelegate
extension MapViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let visibleIndex = round(targetContentOffset.pointee.x / collectionView.frame.width * 1.2)
        let index = Int(abs(visibleIndex))
        
        mapView.clear()
        setupDots(at: index)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension MapViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(self.view.frame.width * 0.8)
        let height = CGFloat(self.collectionView.frame.height)
        return CGSize(width: width, height: height)
    }
}

//MARK: - MapViewProtocol
extension MapViewController: MapViewProtocol {
    func updateCell() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.title = "Знайдено (\(self.presenter.driversCount()))"
        }
        setupDots(at: 0)
    }
}
