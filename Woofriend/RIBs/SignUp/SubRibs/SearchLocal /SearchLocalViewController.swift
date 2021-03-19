//
//  SearchLocalViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/02.
//

import RIBs
import RxSwift
import UIKit

protocol SearchLocalPresentableListener: class {
    func currentLocalAction()
    func backAction()
}

final class SearchLocalViewController: BaseViewController, SearchLocalPresentable, SearchLocalViewControllable {
    
    weak var listener: SearchLocalPresentableListener?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var currentLocalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
    }
    
    private func setUI() {
    }
    
    private func bindUI() {
        
        
        currentLocalButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                self.listener?.currentLocalAction()
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                
                self.listener?.backAction()
            })
            .disposed(by: disposeBag)
    }
    
}

