//
//  ProductDetailView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import UIKit
import SnapKit

protocol ProductDetailViewInterface: AnyObject {
    func AddToWishlistTappedBtn(_ view: ProductDetailView, button addToWishButton: UIButton,quantity:Int)
    func AddToCartButton(_ view: ProductDetailView, addToCartButtonTapped button: UIButton, quantity: Int)
    func productDetailView(_ view: ProductDetailView, stepperValueChanged quantity: Int)
}
protocol ProductDetailViewProtocol {
    var productDetailTitle: String { get }
    var productDetailDescription: String { get }
    var productDetailPrice: String { get }
    var productDetailRatingCount: Double { get }
    var productDetailSold: String { get }
    var productDetailBrand: String { get }
    var productDetailCategory: String { get }
    var productDetailImage: String { get }
}
final class ProductDetailView: UIView{
    weak var interface:ProductDetailViewInterface?
    //MARK: - UI ELEMENTS
    private var productImage = CustomImageView(bacgroundColor: .backgroundColor,contentMode: .scaleAspectFit)
    private var productTitle = CustomLabel(text: "", numberOfLines: 2, font: FiraSana.bold.rawValue, size: 22, textColor: .myYellow ?? .systemYellow, textAlignment: .left)
    var addToWishListButton = CustomButton(backgroundColor: .backgroundColor, image: UIImage(named: "wishlistYellow"), tintColor: .label)
    private var favButtonTitleStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 5, isHidden: false)
    
    
    
    private var salesAmountView = CustomView(backgroundColor: .systemGray5, cornerRadius: 12)
    private var salesAmountLabel = CustomLabel(text: "", numberOfLines: 1, font: FiraSana.bold.rawValue, size: 15, textColor: .label, textAlignment: .center)
    
    private var ratingCountImageView = CustomImageView(image: UIImage(named: "rating"), tintColor: .black, bacgroundColor: .backgroundColor, contentMode: .scaleAspectFit, cornerRadius: 12)
    private var ratingCountLabel = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.regular.rawValue, size: 15, textColor: .label, textAlignment: .center)
    private var ratingCountStackView = CustomStackView(backgroundColor: .backgroundColor, cornerRadius: 12, axis: .horizontal, distiribution: .equalCentering, spacing: 2)
    
    private var productBrand = CustomLabel(text: "", numberOfLines: 1, font: FiraSana.medium.rawValue, size: 15, textColor: .label, textAlignment: .center)
    private var SeparatedLabel = CustomLabel(text: "-", numberOfLines: 1, font: FiraSana.medium.rawValue, size: 15, textColor: .label, textAlignment: .center)
    private var productCategory = CustomLabel(text: "", numberOfLines: 1, font: FiraSana.medium.rawValue, size: 14, textColor: .secondaryLabel, textAlignment: .center)
    private var brandCategoryStackView = CustomStackView(backgroundColor: .backgroundColor, axis: .horizontal, distiribution: .fill, spacing: 2)
    
    
    private var seperatorView = CustomView(backgroundColor: .systemGray2)
    private var descriptionTitle = CustomLabel(text: "Description", numberOfLines: 0, font: FiraSana.medium.rawValue, size: 20, textColor: .label, textAlignment: .left)
    private var descriptionLabel = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.regular.rawValue, size: 18, textColor: .secondaryLabel, textAlignment: .left)
    private var descriptionView = CustomView(backgroundColor: .clear)
    
    
    private var seperatorView2 = CustomView(backgroundColor: .systemGray2)
    private var priceTitle = CustomLabel(text: "Total price", numberOfLines: 0, font: FiraSana.regular.rawValue, size: 17, textColor: .label, textAlignment: .center)
    var priceLabel = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 25, textColor: .label, textAlignment: .center)
    private var priceStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 4, isHidden: false)
    lazy var quantityLabel = CustomLabel(text: "Quantity", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 15, textColor: .label, textAlignment: .center, isHidden: true)
    lazy var stepperPlusButton = CustomButton(backgroundColor: .systemGray5, cornerRadius: 20, image: UIImage(systemName: "plus"), tintColor: .label)
    lazy var stepperLabel = CustomLabel(text: "1", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 20, textColor: .label, textAlignment: .center)
    lazy var stepperMinusButton = CustomButton(backgroundColor: .systemGray5, cornerRadius: 20, image: UIImage(systemName: "minus"), tintColor: .label)
    lazy var stepperStackView = CustomStackView(axis: .horizontal, distiribution: .fill, isHidden: true)
    private let addToCartButton = CustomButton(title: "Add to Cart", titleColor: .white, backgroundColor: .black, cornerRadius: 25, image: UIImage(named: "handbagYellow"), tintColor: .white, imageEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), titleEdgeInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    lazy var cartBtnPriceLblView = CustomView()
    //MARK: - VARS
    var quantity = 1 {
        didSet {
            if quantity <= 0 {
                toggleStepperElements()
                quantity = 0
            } else if quantity > 10 {
                quantity = 10
            }
            stepperLabel.text = String(quantity)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
        setTheView()
        addTargets()
        wishlistBtnToggle()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - functions
    private func toggleStepperElements() {
        stepperStackView.isHidden = !stepperStackView.isHidden
        quantityLabel.isHidden = !quantityLabel.isHidden
    }
    func config(product: ProductDetailViewProtocol){
        self.productImage.downloadSetImage(urlString: product.productDetailImage)
        self.productTitle.text = product.productDetailTitle
        self.descriptionLabel.text = product.productDetailDescription
        self.ratingCountLabel.text = "\(product.productDetailRatingCount)"
        self.priceLabel.text = product.productDetailPrice
        self.salesAmountLabel.text = product.productDetailSold
        self.productBrand.text = product.productDetailBrand
        self.productCategory.text = product.productDetailCategory
    }
    func setTheView(){
        backgroundColor = .backgroundColor
    }
    func addTargets(){
        addToCartButton.addTarget(self, action: #selector(addToCartTappedBtn), for: .touchUpInside)
        addToWishListButton.addTarget(self, action: #selector(ddToWishListTapped), for: .touchUpInside)
         // "+" "-"
        stepperPlusButton.addTarget(self, action: #selector(stepperPlusButtonTapped), for: .touchUpInside)
        stepperMinusButton.addTarget(self, action: #selector(stepperMinusButtonTapped), for: .touchUpInside)
    }
    func wishlistBtnToggle(){
        let image = UIImage(named: "wishlistYellow")
        let imageFill = UIImage(named: "heart")
        addToWishListButton.setImage(image, for: .normal)
        addToWishListButton.setImage(imageFill, for: .selected)
    }
    
    //MARK: - Cart func...
    @objc func addToCartTappedBtn(_ button: UIButton){
        if quantity <= 0 {
            quantity = 1
            stepperStackView.isHidden = false
            quantityLabel.isHidden = false
        }
        stepperStackView.isHidden = false
        quantityLabel.isHidden = false
        interface?.AddToCartButton(self, addToCartButtonTapped: button, quantity: quantity)
    }
    //MARK: - wishlist func...
    @objc func ddToWishListTapped(_ button: UIButton){
        if addToWishListButton.isSelected == false{
            addToWishListButton.setImage(UIImage(named: "heart"), for: .selected)
            interface?.AddToWishlistTappedBtn(self, button: button, quantity: 1)
        }else{
            addToWishListButton.setImage(UIImage(named: "wishlistYellow"), for: .normal)
            interface?.AddToWishlistTappedBtn(self, button: button, quantity: 0)
        }
        addToWishListButton.isSelected.toggle()
    }
    // +
    @objc private func stepperPlusButtonTapped(_ button: UIButton) {
        quantity = quantity + 1
        interface?.productDetailView(self, stepperValueChanged: quantity)
        
    }
    // -
    @objc private func stepperMinusButtonTapped(_ button: UIButton) {
        quantity = quantity - 1
        interface?.productDetailView(self, stepperValueChanged: quantity)
    }
}
//MARK: - UI Elements AddSubiew / Constraints

extension ProductDetailView {
    //MARK: - AddSubview
    private func addSubview() {
        addSubViews([productImage, favButtonTitleStackView, salesAmountView, salesAmountLabel, ratingCountStackView,brandCategoryStackView, seperatorView, descriptionView, quantityLabel, stepperStackView, seperatorView2,priceStackView,cartBtnPriceLblView])
        addFavBtnTitleLblToStackView()
        addRatingElementsToStackView()
        addDescriptionLabelsToView()
        addStepperElementsToStackView()
        addPriceLabelsToStackView()
        addCartBtnPriceLblToStackView()
        addBrandCategoryToStckView()
    }
    
    private func addFavBtnTitleLblToStackView() {
        favButtonTitleStackView.addArrangedSubviews([productTitle, addToWishListButton])
    }
    
    
    private func addRatingElementsToStackView() {
        ratingCountStackView.addArrangedSubviews([ratingCountImageView, ratingCountLabel])
    }
    private func addBrandCategoryToStckView(){
        brandCategoryStackView.addArrangedSubviews([productBrand,SeparatedLabel,productCategory])
    }
    
    private func addAmountLabelToStackView() {
        salesAmountView.addSubview(salesAmountLabel)
    }
    
    private func addDescriptionLabelsToView() {
        descriptionView.addSubViews([descriptionTitle, descriptionLabel])
    }
    
    private func addPriceLabelsToStackView() {
        priceStackView.addArrangedSubviews([priceTitle, priceLabel])
    }
    
    private func addCartBtnPriceLblToStackView() {
        cartBtnPriceLblView.addSubViews([priceStackView, addToCartButton])
    }
    
    private func addStepperElementsToStackView() {
        stepperStackView.addArrangedSubviews([stepperPlusButton, stepperLabel, stepperMinusButton])
    }
    
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        productImageConstraintsh()
        favButtonConstraints()
        favTitleButtonStackViewConstraints()
        salesAmountViewConstraints()
        salesAmountLabelConstraints()
        ratingCountStackViewConstraints()
        brandCategoryViewConstrains()
        seperatorViewConstraints()
        descriptionViewConstraints()
        descriptionTitleConstraints()
        descriptionLabelConstraints()
        quantityLabelConstraints()
        stepperPlusButtonConstraints()
        stepperMinusButtonConstraints()
        stepperElementsStackViewConstraints()
        seperatorView2Constraints()
        addToCartButtonConstraints()
        priceStackViewConstraints()
        cartBtnPriceLblViewConstraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func productImageConstraintsh() {
        productImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY).offset(-50)
        }
    }
    
    private func favButtonConstraints() {
        addToWishListButton.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
    }
    
    private func favTitleButtonStackViewConstraints() {
        favButtonTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(addToWishListButton.snp.bottom)
        }
    }
    
    private func salesAmountViewConstraints() {
        salesAmountView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(35)
            make.top.equalTo(favButtonTitleStackView.snp.bottom).offset(10)
            make.leading.equalTo(favButtonTitleStackView.snp.leading)
        }
    }
    
    private func salesAmountLabelConstraints() {
        salesAmountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(salesAmountView.snp.centerX)
            make.centerY.equalTo(salesAmountView.snp.centerY)
        }
    }
    
    
    private func ratingCountStackViewConstraints() {
        ratingCountStackView.snp.makeConstraints { make in
            make.centerY.equalTo(salesAmountView.snp.centerY)
            make.leading.equalTo(salesAmountView.snp.trailing).offset(8)
        }
        // ratingCountImageView
        ratingCountImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
    }
    private func brandCategoryViewConstrains(){
        brandCategoryStackView.snp.makeConstraints { make in
            make.centerY.equalTo(salesAmountView.snp.centerY)
            make.leading.equalTo(ratingCountStackView.snp.trailing).offset(10)
//            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
    
    private func seperatorViewConstraints() {
        seperatorView.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionView.snp.top).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(0.75)
        }
    }
    
    private func descriptionViewConstraints() {
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(salesAmountView.snp.bottom).offset(20)
            make.leading.equalTo(seperatorView.snp.leading)
            make.trailing.equalTo(seperatorView.snp.trailing)
            make.bottom.equalTo(seperatorView2.snp.top).offset(-10)
        }
    }
    
    private func descriptionTitleConstraints() {
        descriptionTitle.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.top.equalTo(descriptionView.snp.top)
            make.leading.equalTo(descriptionView.snp.leading)
        }
    }
    
    private func descriptionLabelConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(10)
            make.leading.equalTo(descriptionView.snp.leading)
            make.trailing.equalTo(descriptionView.snp.trailing)
            make.height.lessThanOrEqualTo(descriptionView.snp.height).offset(-50)
        }
    }
    
    private func quantityLabelConstraints() {
        quantityLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionView.snp.leading)
            make.bottom.equalTo(seperatorView2.snp.top).offset(-20)
        }
    }
    
    private func stepperPlusButtonConstraints() {
        stepperPlusButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    private func stepperMinusButtonConstraints() {
        stepperMinusButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    private func stepperElementsStackViewConstraints() {
        stepperStackView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.centerY.equalTo(quantityLabel.snp.centerY)
            make.leading.equalTo(quantityLabel.snp.trailing).offset(10)
        }
    }
    
    private func seperatorView2Constraints() {
        seperatorView2.snp.makeConstraints { make in
            make.bottom.equalTo(cartBtnPriceLblView.snp.top).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(0.75)
        }
    }
    
    private func priceStackViewConstraints() {
        priceStackView.snp.makeConstraints { make in
            make.leading.equalTo(cartBtnPriceLblView.snp.leading)
            make.centerY.equalTo(cartBtnPriceLblView.snp.centerY)
        }
    }
    
    private func addToCartButtonConstraints() {
        addToCartButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.trailing.equalTo(cartBtnPriceLblView.snp.trailing)
            make.centerY.equalTo(cartBtnPriceLblView.snp.centerY)
        }
    }
    
    private func cartBtnPriceLblViewConstraints() {
        cartBtnPriceLblView.snp.makeConstraints { make in
            make.height.equalTo(addToCartButton.snp.height)
            make.leading.equalTo(seperatorView2.snp.leading)
            make.trailing.equalTo(seperatorView2.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    
}
