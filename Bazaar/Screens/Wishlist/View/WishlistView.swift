//
//  WishlistView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 26/03/2023.
//

import UIKit

final class WishlistView: UIView{
    
    
    var wishlistCollection = CustomCollection(backgroundColor: .backgroundColor, showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    var wishlistEmptyImage = CustomImageView(image: UIImage(named: "emptyWishlist"), bacgroundColor: .backgroundColor, contentMode: .scaleAspectFit)
    deinit {
        print("WishlistView deinit successfully")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addSubview()
        setupConstraints()
        wishlistEmptyImage.isHidden = true
        wishlistCollection.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI Elements AddSubiew / Constraints

extension WishlistView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubViews([wishlistCollection,wishlistEmptyImage])
    }
    
    //MARK: - SetupConstraints
    
    private func setupConstraints() {
        wishListCollectionAndImageConstraints()
    }
    
    
    //MARK: - UI Elements Constraints
    
    private func wishListCollectionAndImageConstraints() {
        wishlistCollection.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        wishlistEmptyImage.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).offset(-30)
        }
    }
    
    
}
