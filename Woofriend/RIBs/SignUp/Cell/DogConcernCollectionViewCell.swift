//
//  DogConcernCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit
import TagListView

fileprivate enum CollectionViewType: Int {
    case character = 1
    case interest = 2
}

class DogConcernCollectionViewCell: BaseCollectionViewCell, TagListViewDelegate {
    
    @IBOutlet weak var dogCharacterLabel: UILabel!
    @IBOutlet weak var dogInterestLabel: UILabel!
    @IBOutlet weak var characterView: TagListView!
    @IBOutlet weak var interestView: TagListView!
    
    private let mockCharacter = ["적극적", "소극적", "활발함", "예민함", "겁쟁이", "사교적인", "사나움", "에너자이저", "시크함", "고집쟁이", "젠틀함", "영리함"]
    private let mockInterest = ["노즈워킹", "공놀이", "다이어트", "건강", "간식", "수영", "애견카페", "낮잠", "미용", "훈련", "드라이브", "이성친구"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        interestView.delegate = self
        //        bindUI()
    }
    
    func setData() {
        bindUI()
    }
    
    private func bindUI() {
        mockInterest.forEach {
            
            interestView.addTag("#\($0)").onTap = { [weak self] in
                $0.isSelected.toggle()
                print("===== interestView.selectedTags: \(self?.interestView.selectedTags().count)")
            }
            interestView.textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!
        }
        
        mockCharacter.forEach {
            characterView.addTag("#\($0)").onTap = { [weak self] in
                $0.isSelected.toggle()
                print("===== characterView.selectedTags: \(self?.characterView.selectedTags().count)")
            }
            characterView.textFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!
        }
        
    }

}
