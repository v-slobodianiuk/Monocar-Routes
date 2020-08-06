//
//  Presenter.swift
//  Monocar Routes
//
//  Created by Vadym on 06.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import Foundation

protocol MapViewProtocol: class {
    func updateCell()
}

protocol MapPresenterProtocol: class {
    
    init(viewController: MapViewProtocol, networkWorker: NetworkWorkerProtocol, passangerModel: Passanger?, driversModel: Drivers?)
    
    var view: MapViewProtocol? {get set}
    var networkWorker: NetworkWorkerProtocol? {get set}
    var passangerModel: Passanger? {get set}
    var driversModel: Drivers? {get set}
    
    func getData()
    func driversCount() -> Int
    func getDate() -> [(String, String)]
}

class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    internal var networkWorker: NetworkWorkerProtocol?
    var passangerModel: Passanger?
    var driversModel: Drivers?
    
    required init(viewController: MapViewProtocol, networkWorker: NetworkWorkerProtocol, passangerModel: Passanger?, driversModel: Drivers?) {
        self.view = viewController
        self.networkWorker = networkWorker
        self.passangerModel = passangerModel
        self.driversModel = driversModel
    }
    
    func getData() {
        guard let url = networkWorker?.urlComponents(urlPath: "getRequestTest", queryItems: nil) else { return }
        networkWorker?.apiRequest(requestURL: url, requestMethod: "GET", { [weak self] (data) in
            guard let self = self else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    self.passangerModel = Passanger(dictionary: json)
                    self.driversModel = Drivers(dictionary: json)
                    self.reloadCollectionView()
                    print("Hello from Presenter")
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        })
    }
    
    func getDate() -> [(String, String)] {
        var timeArray = [(String, String)]()
        guard let drivers = driversModel?.result else { return timeArray }
        
        for timeInterval in drivers {
            let date = Date(timeIntervalSince1970: TimeInterval(timeInterval.dt_start))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            var tuple = (date: dateFormatter.string(from: date), time: "")
            dateFormatter.dateFormat = "hh:mm"
            tuple.time = dateFormatter.string(from: date)
            timeArray.append(tuple)
        }
        
        return timeArray
    }
    
    func driversCount() -> Int {
        if let drivers = driversModel?.result.count {
            return drivers
        } else {
            return 0
        }
    }
    
    private func reloadCollectionView() {
        self.view?.updateCell()
    }
}
