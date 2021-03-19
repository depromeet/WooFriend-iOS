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
    @IBOutlet weak var sarchBarView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBaseView: UIView!
    weak var remoteConfig: RemoteConfig?
    weak var listener: SearchDogBreedsPresentableListener?
    
    // TODO: firebase remote 추후에 체크해보고
    var dogBreadList = ["골든 리트리버",
                        "꼬똥드툴레아",
                        "닥스훈트",
                        "도베르만",
                        "래브라도 리트리버",
                        "롯드와일러",
                        "마운틴 독",
                        "말티즈",
                        "미니어쳐 핀셔",
                        "믹스견",
                        "보더콜리",
                        "보스턴테리어",
                        "비글",
                        "비숑 프리제",
                        "빠삐용",
                        "사모예드",
                        "슈나우저",
                        "스피츠",
                        "시고르자브종",
                        "시바견",
                        "시베리안 허스키",
                        "시츄",
                        "시페이",
                        "아메리칸 코카 스파니엘",
                        "알래스카 말라뮤트",
                        "요크셔테리어",
                        "웰시코기",
                        "저먼 셰퍼드",
                        "진돗개",
                        "치와와",
                        "토이푸들",
                        "퍼그",
                        "포메라니안",
                        "푸들",
                        "프렌치불독"] {
        didSet {
            self.tableView.reloadData()
            
        }
    }
    
    private var filterDogBreadList = [String]()
    
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
        
        // FIXME: 몇일만에 작업하는데 왜 데이터를 안가져오냐?
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
        sarchBarView.delegate = self
        
        filterDogBreadList = dogBreadList
        
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        remoteConfig?.configSettings = settings
        searchBaseView.layer.cornerRadius = 12
        searchBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        sarchBarView.placeholder = "견종 검색"
        sarchBarView.backgroundImage = nil
        
        if let textfield = sarchBarView.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .white
        }
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

extension SearchDogBreedsViewController: UITableViewDelegate, UITableViewDataSource, UISearchTextFieldDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterDogBreadList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DriectCell")!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DogBread", for: indexPath) as! DogBreadTableViewCell
            cell.dogBreadLabel.text = filterDogBreadList[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row != 0 else {
            self.listener?.directDogBreadAction()
            return
        }
        self.listener?.closeAction(dogBread: filterDogBreadList[indexPath.row - 1])
    }
    
    // MARK: Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterDogBreadList = []
        for bread in dogBreadList {
            print("bread.lowercased       : ", bread.lowercased())
            print("searchText.lowercased  : ", searchText.lowercased())
            if bread.lowercased().contains(searchText.lowercased()) {
                filterDogBreadList.append(bread)
            }
        }
        
        self.tableView.reloadData()
    }
}
