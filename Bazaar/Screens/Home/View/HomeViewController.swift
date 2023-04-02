//
//  HomeViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 19/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Variables
    let homeView = HomeView()
    let homeViewModel = HomeViewModel()
    let productsViewModel = ProductsViewModel()
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.getProfileImage()
        homeViewModel.getUserInfo()
        homeViewModel.getTimeToChangeMorningMsg()
        self.tabBarController?.tabBar.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configView()
        setUpDelegation()
        registerCells()
        productsViewModel.fetchSpecialProducts()
        productsViewModel.fetchAllCategories()
        productsViewModel.fetchAllProducts()
    }
    //MARK: - All Functions
    
    //MARK: - configView
    private func configView(){
        view = homeView
        view.backgroundColor = .backgroundColor
    }
    //MARK: - configureNavBar
    private func configureNavBar() {
        navigationItem.title = "BaZzar"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem?.tintColor = .label
    }
    //MARK: - setUpDelegation
    private func setUpDelegation(){
        homeViewModel.delegate = self
        homeView.interface = self
        homeView.productSearchbar.delegate = self
        
        homeView.specialCollection.delegate = self
        homeView.categoryCollection.delegate = self
        homeView.productsCollection.delegate = self
        
        homeView.specialCollection.dataSource = self
        homeView.categoryCollection.dataSource = self
        homeView.productsCollection.dataSource = self
        
        productsViewModel.delegate = self
        
        
    }
    //MARK: - registerCells
    func registerCells(){
        homeView.specialCollection.register(SpecialProductCell.self, forCellWithReuseIdentifier: SpecialProductCell.identifier)
        homeView.categoryCollection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        homeView.productsCollection.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
}
//MARK: - Extension for scrollView on the pageControll
extension HomeViewController{
    func scrollViewDidEndScrolling(_ scrollView: UIScrollView){
        let width = scrollView.frame.width
        homeView.currentPage = Int(scrollView.contentOffset.x / width)
        print(scrollView.contentOffset.x)
    }
}

//MARK: - Searchbar delegation
extension HomeViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // we can select the search index in tabBar
        tabBarController?.selectedIndex = 1
        // or we can present new search controller
        //        let searchController = SearchViewController()
        //        navigationController?.pushViewController(searchController, animated: true)
    }
}
//MARK: - (Special,Category,Products) delegation and data source...
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //MARK: - Number of Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case homeView.specialCollection:
            return productsViewModel.specialsProducts.count
        case homeView.categoryCollection:
            return productsViewModel.allCategories.count
        case homeView.productsCollection:
            return productsViewModel.productsByCategory.count
        default:
            return 0
        }
    }
    //MARK: - Cell for Item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case homeView.specialCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialProductCell.identifier, for: indexPath)as? SpecialProductCell else{return UICollectionViewCell()}
            cell.configCell(productsViewModel.specialsProducts[indexPath.row])
            return cell
        case homeView.categoryCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)as? CategoryCollectionViewCell else{return UICollectionViewCell()}
            cell.configCell(productsViewModel.allCategories, indexPath: indexPath)
            return cell
        case homeView.productsCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath)as? ProductCollectionViewCell else{return UICollectionViewCell()}
            cell.wishlistBtn.isHidden = true
            cell.configCell(productsViewModel.productsByCategory[indexPath.row])
            cell.interface = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    //MARK: - did Select Item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // did select prodcut...
        switch collectionView{
        case homeView.specialCollection:
            if let productID = productsViewModel.specialsProducts[indexPath.row].id{
                productsViewModel.fetchSingleProduct(productID)
            }
        case homeView.categoryCollection:
            print(productsViewModel.allCategories[indexPath.row])
            let category = productsViewModel.allCategories[indexPath.row]
            if category == "All"{
                productsViewModel.fetchAllProducts()
            }else{
                productsViewModel.fetchProductsByCategory(category)
                // fetch products by category...
            }
        case homeView.productsCollection:
            print(productsViewModel.productsByCategory[indexPath.row].id!)
            if let productID = productsViewModel.productsByCategory[indexPath.row].id{
                productsViewModel.fetchSingleProduct(productID)
            }
        default:
            break
        }
    }
    // This only selects the first cell
    // Will Display
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch collectionView{
        case homeView.productsCollection:
            //for animations
            cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
            UIView.animate(withDuration: 0.35) {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }
        case homeView.specialCollection:
            homeView.currentPage = indexPath.row
            let selectedIndexPath = IndexPath(item: 0, section: 0)
            collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        default:
            break
        }
    }
    //MARK: - CollectionView Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case homeView.specialCollection:
            return CGSize(width: homeView.specialCollection.frame.width - 10, height: homeView.specialCollection.frame.width/2)
        case homeView.productsCollection:
            return CGSize(width: homeView.specialCollection.frame.width/2 - 10, height: homeView.specialCollection.frame.width/1.6)
        default:
            return CGSize(width: 20, height: 20)
        }
    }
}
//MARK: - HomeViewModelDelegation
extension HomeViewController: HomeViewModelDelegation{
    func getCurrentHourSuccesfully() {
        homeView.morningLbl.text = homeViewModel.morningText
    }
    func getUserNameSuccesfully() {
        homeView.usernameLabel.text = homeViewModel.userName
    }
    func getProfileURLSuccesfully(_ url: String) {
        homeView.profileImage.downloadSetImage(urlString: url)
    }
}
//MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface{
    func TappedseeAllBtn(_ view: HomeView, seeAllBtnTapped button: UIButton) {
        print("Tapped SeeAll Btn")
        let specialProductsVC = SpecialProductViewController()
        self.navigationController?.pushViewController(specialProductsVC, animated: true)
    }
    func TappedOnCartBtn(_ view: HomeView, cartBtnTapped button: UIButton) {
        print("Tapped Cart Btn")
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: false)
        //        tabBarController?.selectedIndex = 2
        
    }
    func TappedOnFavoriteBtn(_ view: HomeView, favoriteBtnTapped button: UIButton) {
        print("Tapped Favorite Btn")
        let wishlistVC = WishlistViewController()
        navigationController?.pushViewController(wishlistVC, animated: true)
    }
}
//MARK: - Products viewModel delegation...
extension HomeViewController:ProductsViewModelDelegation{
    
    func errorHapped(_ error: Error) {
        print("Error :( \(error.localizedDescription)")
    }
    func didFetchSpecialProductsSuccessful() {
        DispatchQueue.main.async {[weak self] in
            self?.homeView.pageController.numberOfPages = self?.productsViewModel.specialsProducts.count ?? 0
        }
        self.homeView.specialCollection.reloadData()
    }
    func didFetchCategoriesSuccessful() {
            self.homeView.categoryCollection.reloadData()
    }
    func didFetchAllProductsSuccessful() {
            self.homeView.productsCollection.reloadData()
    }
    func didFetchProductsByCategorySuccessful() {
            self.homeView.productsCollection.reloadData()
    }
    func didFetchSingleProductSuccessful(_ product: Product) {
        let productDetailVC = ProductDetailViewController(product: product)
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    func didUpdateWishListSuccessful() {
        print("Update WishList Successful")
        
    }
}
//MARK: - ProductCollectionCellProtocol for wishlist buttons
extension HomeViewController: ProductsCollectionViewCellInterface{
    func productCollectionCell(_ view: ProductCollectionViewCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton) {
        productsViewModel.updateWishList(productId: productId, quantity: quantity)
    }
}

