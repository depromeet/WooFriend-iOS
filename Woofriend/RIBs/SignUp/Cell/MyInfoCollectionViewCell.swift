//
//  MyInfoCollectionViewCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/21.
//

import UIKit

class MyInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var menButton: UIButton!
    @IBOutlet weak var womenButton: UIButton!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var townNameLabel: UILabel!
    @IBOutlet weak var 동네뷰: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
