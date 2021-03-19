//
//  MyInfoViewController.swift
//  Woofriend
//
//  Created by 이규현 on 2021/03/17.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import Photos
import CropViewController

protocol MyInfoPresentableListener: class {
    func nextAction()
    func backAction()
    func nextLocal()
}

final class MyInfoViewController: BaseViewController, MyInfoPresentable, MyInfoViewControllable {
    
    weak var listener: MyInfoPresentableListener?
    
    @IBOutlet weak var photoLayer: UIView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLayer: UIView!
    @IBOutlet weak var menButton: UIButton!
    @IBOutlet weak var womenButton: UIButton!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var yearLayer: UIView!
    @IBOutlet weak var townNameLabel: UILabel!
    @IBOutlet weak var townView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resionLayer: UIView!
    @IBOutlet weak var indicatiorTrailingConstraint: NSLayoutConstraint!
    
    let imagePickerController = UIImagePickerController()
    var address: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    var myProfile: MyProfile? = MyProfile() {
        didSet {
            self.nextButton.backgroundColor = !(self.myProfile?.hasNilField() ?? true) ? #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1) : #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        bindUI()
    }
    
    private func setUI() {
        imagePickerController.delegate = self
        imagePickerController.sourceType = .savedPhotosAlbum
        photoLayer.layer.cornerRadius = photoLayer.frame.width / 2
        let current = self.view.bounds.width / 6
        self.indicatiorTrailingConstraint.constant = current * CGFloat((5 - 4))
        nameTextField.addDoneButtonOnKeyboard()
        yearTextField.addDoneButtonOnKeyboard()
        monthTextField.addDoneButtonOnKeyboard()
        dayTextField.addDoneButtonOnKeyboard()
    }
    
    private func bindUI() {
        
        address.ifEmpty(default: nil)
            .bind(to: townNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        view.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.nameTextField.resignFirstResponder()
                self.yearTextField.resignFirstResponder()
                self.monthTextField.resignFirstResponder()
                self.dayTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        menButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.menButton.isSelected = true
                self?.myProfile?.gender = "M"
                self?.menButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.menButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.menButton.layer.borderColor = UIColor.clear.cgColor
                self?.menButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
                
                self?.womenButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
                self?.womenButton.isSelected = false
                self?.womenButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.womenButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.womenButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        
        womenButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.myProfile?.gender = "W"
                self?.womenButton.isSelected = true
                self?.womenButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.womenButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.womenButton.layer.borderColor = UIColor.clear.cgColor
                self?.womenButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
                
                self?.menButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
                self?.menButton.isSelected = false
                self?.menButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.menButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.menButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        photoLayer.rx.tapGesture().asSignal()
            .emit { [weak self] tap in
                guard let self = self else { return }
                // FIXME: 확인해서 rawValue enum으로
                guard tap.state.rawValue == 3 /* UIGestureRecognizerState.ended */ else { return }
                
                DispatchQueue.main.async {
                    UIApplication.topViewController()?.present(self.imagePickerController, animated: true, completion: nil)
                }
                
            }
            .disposed(by: disposeBag)
        
        // MARK: 텍스트 필드
        
        nameTextField.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                if new.count > 6 {
                    return prev
                } else {
                    self?.myProfile?.name = new
                    return new
                }
            })
            .bind(to: nameTextField.rx.text)
            .disposed(by: disposeBag)
        
        yearTextField.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                if new.count > 4 {
                    return prev
                } else {
                    self?.myProfile?.year = new
                    return new
                }
            })
            .bind(to: yearTextField.rx.text)
            .disposed(by: disposeBag)
        
        monthTextField.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                    if new.count > 2 {
                        return prev
                    } else {
                        self?.myProfile?.month = new
                        return new
                    }
            })
            .bind(to: monthTextField.rx.text)
            .disposed(by: disposeBag)
        
        dayTextField.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                    if new.count > 2 {
                        return prev
                    } else {
                        self?.myProfile?.day = new
                        return new
                    }
            })
            .bind(to: dayTextField.rx.text)
            .disposed(by: disposeBag)
        
        nameTextField.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(onNext: { [weak self] in
                self?.nameLayer.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        nameTextField.rx.controlEvent(.editingDidEnd).asSignal()
            .emit(onNext: { [weak self] in
                self?.nameLayer.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        
        yearTextField.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(onNext: { [weak self] in
                self?.yearLayer.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        yearTextField.rx.controlEvent(.editingDidEnd).asSignal()
            .emit(onNext: { [weak self] in
                self?.yearLayer.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        
        monthTextField.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(onNext: { [weak self] in
                self?.yearLayer.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        monthTextField.rx.controlEvent(.editingDidEnd).asSignal()
            .emit(onNext: { [weak self] in
                self?.yearLayer.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        
        dayTextField.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(onNext: { [weak self] in
                self?.yearLayer.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        dayTextField.rx.controlEvent(.editingDidEnd).asSignal()
            .emit(onNext: { [weak self] in
                self?.yearLayer.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        townView.rx.tapGesture().asSignal()
            .emit { [weak self] _ in
                self?.listener?.nextLocal()
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }
                if !(self.myProfile?.hasNilField() ?? true) {
                    self.listener?.nextAction()
                } else {
                    self.nameLayer.layer.borderColor = self.myProfile?.name?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.menButton.layer.borderColor = self.myProfile?.gender == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.womenButton.layer.borderColor = self.myProfile?.gender == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.yearLayer.layer.borderColor = self.myProfile?.year?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.yearLayer.layer.borderColor = self.myProfile?.month?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.yearLayer.layer.borderColor = self.myProfile?.day?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.resionLayer.layer.borderColor = self.myProfile?.region?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.photoLayer.layer.borderColor = self.myProfile?.photo == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                }
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

extension MyInfoViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate, CropViewControllerDelegate {
    
    func presentCropViewController(image: UIImage?) {
        let cropViewController = CropViewController(croppingStyle: .circular, image: image ?? UIImage())
        
        cropViewController.doneButtonTitle = "완료"
        cropViewController.doneButtonColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
        cropViewController.cancelButtonTitle = "취소"
        cropViewController.cancelButtonColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cropViewController.delegate = self
        UIApplication.topViewController()?.present(cropViewController, animated: false, completion: nil)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
//        self.plusImageView.isHidden = true
        photoLayer.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        myProfile?.photo = image
        profile.image = image
        cropViewController.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePickerController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            self.presentCropViewController(image: info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
            
        }
    }
}
