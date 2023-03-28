//
//  HomeView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 21/03/2023.
//

import UIKit
import SnapKit


protocol HomeViewInterface: AnyObject{
    func TappedOnCartBtn(_ view : HomeView,cartBtnTapped button: UIButton)
    func TappedOnFavoriteBtn(_ view : HomeView, favoriteBtnTapped button: UIButton)
    func TappedseeAllBtn(_ view : HomeView , seeAllBtnTapped button: UIButton)
}
final class HomeView: UIView{
    //MARK: - Proparties
    weak var interface: HomeViewInterface?
    //MARK: - Ui elements
     var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private var contentView = CustomView()
    var profileImage = CustomImageView(image: UIImage(named: "person")!, tintColor: .black, bacgroundColor: .systemGray6, contentMode: .scaleToFill, maskToBound: true, cornerRadius: 35, isUserInteractionEnabled: false)
    var morningLbl = CustomLabel(text: "Good morning 👋🏼", numberOfLines: 0,font: FiraSana.bold.rawValue, size: 16, textColor: .systemGray, textAlignment: .left)
    var usernameLabel = CustomLabel(text: "khaled Hussien", numberOfLines: 0,font: FiraSana.bold.rawValue, size: 18, textColor: .label, textAlignment: .left)
    private var labelsStackView = CustomStackView(axis: .vertical, distiribution: .fillProportionally, spacing: 0, isHidden: false)
    private var btnsStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 12, isHidden: false)
    
    private var favoriteBtn = CustomButton(backgroundColor: .clear, image: UIImage(named: "heart"), tintColor: .label)
    private var cartBtn = CustomButton(backgroundColor: .clear, image: UIImage(named: "cart"), tintColor: .label)
    var productSearchbar = CustomSearchBar(showBookmarkBtn: false,placeholder: "Seach Products",bacgroundColor: .backgroundColor)
    private var specialProductsLabel = CustomLabel(text: "Special Products", numberOfLines: 0, font: FiraSana.medium.rawValue, size: 20, textColor: .label, textAlignment: .left)
    private var seeAllBtn = CustomButton(title: "See more", titleColor: .label, font: .boldSystemFont(ofSize: 15), image: UIImage(named: "seeAll"),imageEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
    private var specialLblSeeBtnView = CustomView()
    // Special Collection
    var specialCollection = CustomCollection(backgroundColor: .backgroundColor, cornerRadius: 30, showsScrollIndicator: false, paging: true, layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal)
    var pageController = CustomPageController()
    // categories Collection
    var categoryCollection = CustomCollection(backgroundColor: .backgroundColor,showsScrollIndicator: false, paging: true, layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal,estimatedItemSize: UICollectionViewFlowLayout.automaticSize,minimumInteritemSpacing: 0,minimumLineSpacing: 0)
    // products Collection
    var productsCollection = CustomCollection(backgroundColor: .backgroundColor, showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical,minimumInteritemSpacing: 20,minimumLineSpacing: 20)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSupViews()
        setUpConstrains()
        addTargets()
        configSearchBar()
        pageController.currentPageIndicatorTintColor = .myYellow
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Add target
    func addTargets(){
        favoriteBtn.addTarget(self, action: #selector(TaapedFavoriteBtn), for: .touchUpInside)
        cartBtn.addTarget(self, action: #selector(TaapedCartBtn), for: .touchUpInside)
        seeAllBtn.addTarget(self, action: #selector(TaapedSeeAllBtn), for: .touchUpInside)
    }
    @objc func TaapedFavoriteBtn(_ button: UIButton){
        interface?.TappedOnFavoriteBtn(self, favoriteBtnTapped: button)
    }
    @objc func TaapedCartBtn(_ button: UIButton){
        interface?.TappedOnCartBtn(self, cartBtnTapped: button)
    }
    @objc func TaapedSeeAllBtn(_ button: UIButton){
        interface?.TappedseeAllBtn(self, seeAllBtnTapped: button)
    }
    //MARK: - configSearchBar
    private func configSearchBar(){
        productSearchbar.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)
    }
    //MARK: - page controll..
    var currentPage: Int = 0{
        didSet{
            pageController.currentPage = currentPage
        }
    }
}

//MARK: - Constrains and SubViews
extension HomeView{
    //MARK: - SubViews
    func setUpSupViews(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubViews([profileImage,morningLbl,usernameLabel,labelsStackView,btnsStackView,productSearchbar,specialLblSeeBtnView,specialCollection,pageController,categoryCollection,productsCollection])
        addTopLabelToStackView()
        addTopBtnToStackView()
        addSpecialSeeToView()
    }
    private func addTopLabelToStackView(){
        labelsStackView.addArrangedSubviews([morningLbl,usernameLabel])
    }
    private func addTopBtnToStackView(){
        btnsStackView.addArrangedSubviews([favoriteBtn,cartBtn])
    }
    private func addSpecialSeeToView(){
        specialLblSeeBtnView.addSubViews([specialProductsLabel,seeAllBtn])
    }
    
    //MARK: - Constrains
    func setUpConstrains(){
        // scroll view
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        // content view
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(1100)
        }
        // profile image
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(15)
            make.height.width.equalTo(70)
        }
        // stack view for top labels...
        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.centerY.equalTo(profileImage.snp.centerY)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
        }
        // stack view for top Btns...
        btnsStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.centerY.equalTo(profileImage.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
        }
        // search bar
        productSearchbar.snp.makeConstraints { make in
            make.top.equalTo(btnsStackView.snp.bottom).offset(10)
            make.leading.equalTo(profileImage.snp.leading)
            make.trailing.equalTo(btnsStackView.snp.trailing)
        }
        // speical prosucts and see all btn view
        specialLblSeeBtnView.snp.makeConstraints { make in
            make.height.equalTo(specialProductsLabel.snp.height)
            make.top.equalTo(productSearchbar.snp.bottom).offset(10)
            make.leading.equalTo(productSearchbar.snp.leading)
            make.trailing.equalTo(productSearchbar.snp.trailing)
        }
        // special products
        specialProductsLabel.snp.makeConstraints { make in
            make.leading.equalTo(specialLblSeeBtnView.snp.leading)
            make.centerY.equalTo(specialLblSeeBtnView.snp.centerY)
            make.trailing.equalTo(seeAllBtn.snp.leading)
        }
        // see all btn
        seeAllBtn.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.centerY.equalTo(specialLblSeeBtnView.snp.centerY)
            make.trailing.equalTo(specialLblSeeBtnView.snp.trailing).offset(10)
        }
        // special produts collection view...
        specialCollection.snp.makeConstraints { make in
            make.top.equalTo(specialLblSeeBtnView.snp.bottom).offset(5)
//            make.bottom.equalTo(scrollView.snp.centerY).offset(50)
            make.height.equalTo(170)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
        }
        // page controll
         pageController.snp.makeConstraints({ make in
            make.top.equalTo(specialCollection.snp.bottom).offset(5)
             make.centerX.equalTo(specialCollection.snp.centerX)
             make.leading.equalTo(specialCollection.snp.leading).offset(80)
             make.trailing.equalTo(specialCollection.snp.trailing).offset(-80)
//             make.width.equalTo(160)
        })
        // category collection
        categoryCollection.snp.makeConstraints { make in
            make.top.equalTo(pageController.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.width.equalTo(specialCollection.snp.width)
            make.height.equalTo(specialCollection.snp.width).multipliedBy(0.2)
        }
        // products collection
        productsCollection.snp.makeConstraints { make in
            make.top.equalTo(categoryCollection.snp.bottom).offset(20)
            make.leading.equalTo(specialCollection.snp.leading)
            make.trailing.equalTo(specialCollection.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}
