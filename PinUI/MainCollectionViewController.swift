//
//  MainCollectionViewController.swift
//  PinUI
//
//  Created by ktds 29  on 2017. 8. 31..
//  Copyright © 2017년 ktds 29 . All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
var photos:[UIImage] = [UIImage]()
class MainCollectionViewController: UICollectionViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photos.append(UIImage(named : "1")!)
        photos.append(UIImage(named : "2")!)
        photos.append(UIImage(named : "3")!)
        photos.append(UIImage(named : "4")!)
        photos.append(UIImage(named : "5")!)
        photos.append(UIImage(named : "6")!)
        photos.append(UIImage(named : "7")!)
        photos.append(UIImage(named : "8")!)
        photos.append(UIImage(named : "9")!)
        photos.append(UIImage(named : "10")!)
        photos.append(UIImage(named : "11")!)
        photos.append(UIImage(named : "12")!)
        photos.append(UIImage(named : "13")!)
        photos.append(UIImage(named : "14")!)
        photos.append(UIImage(named : "15")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let photoCell = cell as? PinCollectionViewCell {
            
            let img = photos[indexPath.row]
            
            photoCell.imgView.image = photos[indexPath.row]
        }
    
        return cell
    }

}

class CollectionViewFlowLayout: UICollectionViewFlowLayout {

    var layoutCache: [UICollectionViewLayoutAttributes]? = nil
    override func prepare() {
        super.prepare()
        let width = (collectionView?.bounds.size.width ?? 375) / 2 - 5
        
        guard layoutCache == nil else { return }
        
        var attrsList: [UICollectionViewLayoutAttributes] = []
        for (index, image) in photos.enumerated() {
            let isOdd = index % 2 == 0
            let attrs = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
            let ratio = image.size.height / image.size.width
            let height = width * ratio
            
            var frame = CGRect(x: isOdd ? 0 : width + 10, y: 0, width: width, height: height)
            if index > 1 {
                let upperImage = attrsList[index-2]
                frame.origin.y = upperImage.frame.origin.y + upperImage.frame.size.height + 10
            }
            attrs.frame = frame
            
            attrsList.append(attrs)
        }
        layoutCache = attrsList
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutCache = layoutCache else { return super.layoutAttributesForElements(in: rect) }
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in layoutCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
}


