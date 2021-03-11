//
//  SearchDogBreedsViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift
import RxCocoa
import RxDataSources
import UIKit
import Firebase

protocol SearchDogBreedsPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func closeAction(dogBread: String?)
    func directDogBreadAction()
}

final class SearchDogBreedsViewController: BaseViewController, SearchDogBreedsPresentable, SearchDogBreedsViewControllable {
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBaseView: UIView!
    weak var remoteConfig: RemoteConfig?
    weak var listener: SearchDogBreedsPresentableListener?
    var dogBreadList = [String]() { didSet { self.tableView.reloadData() } }
    private var savedDogBreadList = [String]()
    
    static func instantiate() -> SearchDogBreedsViewController {
        let vc = Storyboard.SearchDogBreedsViewController.instantiate(SearchDogBreedsViewController.self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // FIXME: 일딴 임시
        remoteConfig?.fetch(withExpirationDuration: 180, completionHandler: { [weak self] (status, err) in
            guard let self = self else { return }
            
            if status == .success {
                let data = self.remoteConfig?["dog_bread_list"].dataValue
                if let dict = try? JSONDecoder().decode([String: [String]].self, from: data!), let list = dict["list"] {
                    self.dogBreadList = list
                }
            }
        })
    }
    
    private func setUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        remoteConfig?.configSettings = settings
        searchBaseView.layer.cornerRadius = 12
        searchBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func bindUI() {
        
        dimView.rx.tapGesture().asSignal()
            .emit { [weak self] tap in
                guard let self = self else { return }
                guard tap.state.rawValue == 3 /* UIGestureRecognizerState.ended */ else { return }
                
                self.listener?.closeAction(dogBread: nil)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchDogBreedsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dogBreadList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DriectCell")!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DogBread", for: indexPath) as! DogBreadTableViewCell
            cell.dogBreadLabel.text = dogBreadList[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listener?.closeAction(dogBread: dogBreadList[indexPath.row - 1])
    }
}
