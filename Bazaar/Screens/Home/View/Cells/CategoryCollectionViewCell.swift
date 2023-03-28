//
//  CategoryCollectionViewCell.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 22/03/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    //MARK: - uielements
    var categoryImage = CustomImageView(tintColor: .label, bacgroundColor: .backgroundColor, contentMode: .scaleToFill, isUserInteractionEnabled: false)
    var categoryTitle = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 14, textColor: .secondaryLabel, textAlignment: .center)
    private var categoryView = CustomView(backgroundColor: .backgroundColor)
    
    static let identifier = "CategoryCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDesign()
        setUpViews()
        setupConstrains()
    }
    func setupDesign(){
        backgroundColor = .backgroundColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configCell(_ category: Categories,indexPath: IndexPath){
        categoryTitle.text = category[indexPath.row].capitalized
        categoryImage.image = UIImage(named: "category\(category[indexPath.row])")
        print("category\(category[indexPath.row])")
    }
}
//MARK: - subviews & constrains
extension CategoryCollectionViewCell{
    func setUpViews(){
        addSubview(categoryView)
        categoryView.addSubViews([categoryImage,categoryTitle])
    }
    func setupConstrains(){
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(100)
            make.height.equalTo(80)
        }
        categoryImage.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.top).offset(5)
            make.centerX.equalTo(categoryView.snp.centerX)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        categoryTitle.snp.makeConstraints { make in
            make.top.equalTo(categoryImage.snp.bottom)
            make.bottom.equalTo(categoryView.snp.bottom)
            make.leading.equalTo(categoryView.snp.leading)
            make.trailing.equalTo(categoryView.snp.trailing)
        }
    }
}
