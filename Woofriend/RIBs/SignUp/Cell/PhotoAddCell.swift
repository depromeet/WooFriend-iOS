//
//  PhotoAddCell.swift
//  Woofriend
//
//  Created by 이규현 on 2021/02/23.
//

import UIKit

class PhotoAddCell: UICollectionViewCell {

    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setData(image: UIImage?) {
        guard let image = image else { return }
        addImageView.image = image
        
    }

}
