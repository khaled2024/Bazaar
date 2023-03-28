//
//  ProductsCollectionViewCell.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import UIKit
protocol ProductCollectionCellProtocol {
    var productId: Int { get }
    var productTitle: String { get }
    var productRatingCount: Double { get }
    var productPrice: String { get }
    var productBrand: String {get}
    var productImage: String { get }
    var productSold: String { get }
}
protocol ProductsCollectionViewCellInterface: AnyObject{
    func productCollectionCell(_ view: ProductCollectionViewCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton)
}
class ProductCollectionViewCell: UICollectionViewCell {
    //MARK: - Proparties
    static let identifier = "ProductsCollectionViewCell"
    weak var interface: ProductsCollectionViewCellInterface?
    var productID: Int?
    
    //MARK: - ui Elements...
    var productImage = CustomImageView(image: UIImage(named: "noImage2"), bacgroundColor: .clear, contentMode: .scaleToFill, maskToBound: true, cornerRadius: 20, isUserInteractionEnabled: false)
    var wishlistBtn = CustomButton(title: "", titleColor: .label, image: UIImage(named: "wishlist"), contentHorizontalAlignment: .center, contentVerticalAignment: .center, tintColor: .label)
    // categoryTitleStackView
    var categoryTitleProductStackView = CustomStackView(axis: .vertical, spacing: 5, isHidden: false)
    var brandProduct = CustomLabel(text: "", numberOfLines: 1, font: FiraSana.regular.rawValue, size: 13, textColor: .secondaryLabel, textAlignment: .left)
    var productTitle = CustomLabel(text: "", numberOfLines: 1, font: FiraSana.bold.rawValue, size: 15, textColor: .label, textAlignment: .left)
    
    // Lables StackView
    var lablesProductStackView = CustomStackView(axis: .horizontal, spacing: 3, isHidden: false)
    var ratingImage = CustomImageView(image: UIImage(named: "rating"), tintColor: .systemYellow, bacgroundColor: .clear, contentMode: .scaleAspectFit, maskToBound: false, cornerRadius: 0, isUserInteractionEnabled: false)
    var ratingLbl = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.regular.rawValue, size: 12, textColor: .secondaryLabel, textAlignment: .left)
    var soldLbl = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.regular.rawValue, size: 12, textColor: .secondaryLabel, textAlignment: .left)
    var priceLbl = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 17, textColor: UIColor.myYellow!, textAlignment: .right)
    var anyView = CustomView(backgroundColor: .systemGray3)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        addConstrains()
        setDesign()
        addTargets()
        toggleAddButton()
    }
    func addTargets(){
        wishlistBtn.addTarget(self, action: #selector(wishlistTapped), for: .touchUpInside)
    }
    @objc func wishlistTapped(_ button: UIButton){
        print("Wishlist tapped")
        guard let productID = productID else{return}
        if wishlistBtn.isSelected == false{
            interface?.productCollectionCell(self, productId: productID, quantity: 1, wishButtonTapped: button)
//            self.wishlistBtn.setImage( UIImage(named: "heart"), for: .selected)
            print(productID)
        }else{
            interface?.productCollectionCell(self, productId: productID, quantity: 0, wishButtonTapped: button)
//            self.wishlistBtn.setImage( UIImage(named: "wishlist"), for: .normal)
            print(productID)
        }
        wishlistBtn.isSelected.toggle()
    }
    func toggleAddButton() {
        let image = UIImage(named: "wishlist")
        let imageFilled = UIImage(named: "heart")
//        let image = UIImage(named: "heart")
//        let imageFilled = UIImage(named: "heart")
        wishlistBtn.setImage(image, for: .normal)
        wishlistBtn.setImage(imageFilled, for: .selected)
    }
    //MARK: - setDesign
    func setDesign(){
        backgroundColor = .ProductsCollectionColor
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.cornerRadius = 20
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - configCell
    func configCell(_ product: ProductCollectionCellProtocol){
        self.productImage.downloadSetImage(urlString: product.productImage)
        self.priceLbl.text = product.productPrice
        self.productTitle.text = product.productTitle
        self.brandProduct.text = product.productBrand
        self.soldLbl.text = product.productSold
        self.ratingLbl.text = "\(product.productRatingCount)"
        self.productID = product.productId
    }
}
//MARK: - SubViews and Constrains...
extension ProductCollectionViewCell{
    func addSubViews(){
        addSubViews([productImage,wishlistBtn,categoryTitleProductStackView,lablesProductStackView,priceLbl])
        categoryTitleProductStackView.addArrangedSubviews([brandProduct,productTitle])
        lablesProductStackView.addArrangedSubviews([ratingImage,ratingLbl,anyView,soldLbl])
    }
    func addConstrains(){
        productImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
        }
        wishlistBtn.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.width.equalTo(22)
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
        }
        
        categoryTitleProductStackView.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-5)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY).offset(80)
        }
        ratingImage.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        anyView.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(1.5)
        }
        lablesProductStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.centerX).offset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-5)
        }
        priceLbl.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
}
