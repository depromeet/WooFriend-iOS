//
//  DogNameCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import RxGesture
import Photos
import CropViewController

class DogNameCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var dogProfileView: UIView!
    @IBOutlet weak var dogProfileImageView: UIImageView!
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var otherDogButton: UIButton!
    @IBOutlet weak var dogNameLayerView: UIView!
    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogMenButton: UIButton!
    @IBOutlet weak var dogWomenButton: UIButton!
    @IBOutlet weak var dogAgeLayerView: UIView!
    @IBOutlet weak var dogAgeTextField: UITextField!
    @IBOutlet weak var multiDogInfoView: UIView!
    @IBOutlet weak var multiDogInfoCloseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private var dogProfile: DogProfile? = DogProfile() {
        willSet {
            self.nextButton.backgroundColor = !(self.dogProfile?.hasNilField() ?? true) ? #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1) : #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        }
    }
    
    let imagePickerController = UIImagePickerController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        bindUI()
    }
    
    private func keyboradHideAll() {
        self.dogNameTextField.resignFirstResponder()
        self.dogAgeTextField.resignFirstResponder()
    }
    
    private func setUI() {
        imagePickerController.delegate = self
        imagePickerController.sourceType = .savedPhotosAlbum
        dogProfileImageView.layer.cornerRadius = dogProfileImageView.frame.width / 2
        dogNameTextField.addDoneButtonOnKeyboard()
        dogAgeTextField.addDoneButtonOnKeyboard()
    }
    
    private func bindUI() {
        multiDogInfoView.isHidden = true
        
        contentView.rx.tapGesture().asSignal()
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.dogNameTextField.resignFirstResponder()
                self.dogAgeTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        dogProfileView.rx.tapGesture().asSignal()
            .emit { [weak self] tap in
                guard let self = self else { return }
                // FIXME: 확인해서 rawValue enum으로
                guard tap.state.rawValue == 3 /* UIGestureRecognizerState.ended */ else { return }
                
                // FIXME: 더럽..
                switch PHPhotoLibrary.authorizationStatus() {
                
                case .authorized:
                    DispatchQueue.main.async {
                        UIApplication.topViewController()?.present(self.imagePickerController, animated: true, completion: nil)
                    }
                    
                default:
                    PHPhotoLibrary.requestAuthorization { status in
                        
                        switch status {
                        case .authorized:
                            DispatchQueue.main.async {
                                UIApplication.topViewController()?.present(self.imagePickerController, animated: true, completion: nil)
                            }
                        default:
                            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        otherDogButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.multiDogInfoView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        multiDogInfoCloseButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.multiDogInfoView.isHidden = true
            })
            .disposed(by: disposeBag)
        
        
        dogMenButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dogProfile?.gender = "M"
                self?.dogNameTextField.resignFirstResponder()
                self?.dogAgeTextField.resignFirstResponder()
                self?.dogMenButton.isSelected = true
                self?.dogMenButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.dogMenButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.dogMenButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
                self?.dogMenButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.dogWomenButton.isSelected = false
                self?.dogWomenButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.dogWomenButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.dogWomenButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                self?.dogWomenButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
            })
            .disposed(by: disposeBag)
        
        
        dogWomenButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                self?.dogProfile?.gender = "W"
                self?.dogNameTextField.resignFirstResponder()
                self?.dogAgeTextField.resignFirstResponder()
                self?.dogWomenButton.isSelected = true
                self?.dogWomenButton.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1)
                self?.dogWomenButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                self?.dogMenButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)!
                self?.dogWomenButton.layer.borderColor = UIColor.clear.cgColor
                
                self?.dogMenButton.isSelected = false
                self?.dogMenButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self?.dogMenButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), for: .normal)
                self?.dogWomenButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Semibold", size: 14)!
                self?.dogMenButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        // MARK: 텍스트 필드
        dogNameTextField.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(onNext: { [weak self] in
                self?.dogNameLayerView.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        dogNameTextField.rx.controlEvent(.editingDidEnd).asSignal()
            .emit(onNext: { [weak self] in
                self?.dogNameLayerView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        dogNameTextField.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                
                if new.count > 6 {
                    return prev
                } else {
                    self?.dogProfile?.name = new
                    return new
                }
            })
            .bind(to: dogNameTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        dogAgeTextField.rx.controlEvent(.editingDidBegin).asSignal()
            .emit(onNext: { [weak self] in
                self?.dogAgeLayerView.layer.borderColor = #colorLiteral(red: 0.0862745098, green: 0.8196078431, blue: 0.5882352941, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        dogAgeTextField.rx.controlEvent(.editingDidEnd).asSignal()
            .emit(onNext: { [weak self] in
                self?.dogAgeLayerView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            })
            .disposed(by: disposeBag)
        
        dogAgeTextField.rx.text.orEmpty
            .scan("", accumulator: { [weak self] (prev, new) -> String in
                print(new)
                if new.count > 2 {
                    return prev
                } else {
                    self?.dogProfile?.age = new
                    return new
                }
            })
            .bind(to: dogAgeTextField.rx.text)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] b in
                guard let self = self else { return }

                if !(self.dogProfile?.hasNilField() ?? true) {
                    self.isChecked.accept(true)
                } else {
                    self.isChecked.accept(false)
                    self.dogNameLayerView.layer.borderColor = self.dogProfile?.name?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.dogWomenButton.layer.borderColor = self.dogProfile?.gender?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.dogMenButton.layer.borderColor = self.dogProfile?.gender?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.dogAgeLayerView.layer.borderColor = self.dogProfile?.age?.isEmpty ?? true ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
                    self.dogProfileImageView.layer.borderColor = self.dogProfile?.photo == nil ?  #colorLiteral(red: 1, green: 0.4666666667, blue: 0.5294117647, alpha: 1).cgColor :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
                }
            })
            .disposed(by: disposeBag)
    }
}

extension DogNameCollectionViewCell: UIImagePickerControllerDelegate & UINavigationControllerDelegate, CropViewControllerDelegate {
    
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
        
        self.plusImageView.isHidden = true
        dogProfileImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        dogProfile?.photo = image
        dogProfileImageView.image = image
        cropViewController.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePickerController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            self.presentCropViewController(image: info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
            
        }
    }
}
