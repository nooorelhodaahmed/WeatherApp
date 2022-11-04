//
//  CollectionViewCell.swift
//  WeatherApp
//
//  Created by norelhoda on 02/11/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    //MARK: - Proporties
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempratueLabel : UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
