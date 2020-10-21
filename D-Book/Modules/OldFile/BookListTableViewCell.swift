//
//  BookListTableViewCell.swift
//  D-Book
//
//  Created by 강민석 on 2020/06/05.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class BookListTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BookListTableViewCell: UICollectionViewDelegate {
    
}

//extension BookListTableViewCell: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
