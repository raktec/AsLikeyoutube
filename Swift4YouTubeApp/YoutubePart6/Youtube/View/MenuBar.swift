//
//  MenuBar.swift
//  Youtube
//
//  Created by Rakesh Kumar Sharma on 09/11/17.
//  Copyright © 2017 Rakesh Kumar Sharma. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "cellId"
    let imageName = ["home","trending","subscriptions","account"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor =  UIColor.rgb(red: 230, green: 32, blue: 31)
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        let selectedIndex = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndex as IndexPath, animated: false, scrollPosition: .bottom)
        setupHorizontalBar()

    }
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?

    func setupHorizontalBar(){
        
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let imagename = imageName[indexPath.item]
        cell.thumbnailIcon.image = UIImage(named: imagename)?.withRenderingMode(.alwaysTemplate)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 4
        horizontalBarLeftAnchorConstraint?.constant = x
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MenuCell:BaseCell{
    
    let thumbnailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return imageView
    }()
    
    override var isHighlighted: Bool{
        didSet{
            thumbnailIcon.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    override var isSelected: Bool{
        didSet{
            thumbnailIcon.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)

        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(thumbnailIcon)
        addConstraintsWithFormat(format:"H:[v0(28)]", views: thumbnailIcon)
        addConstraintsWithFormat(format:"V:[v0(28)]", views: thumbnailIcon)
        addConstraint(NSLayoutConstraint(item: thumbnailIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumbnailIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))


    }
    
   
}
