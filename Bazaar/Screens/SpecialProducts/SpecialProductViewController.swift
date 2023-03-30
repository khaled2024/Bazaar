//
//  SpecialProductViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 22/03/2023.
//

import UIKit

class SpecialProductViewController: UIViewController {

    private let specialProductsView = SpecialProductView()
    private let specialProductsViewModel = SpecialProductViewModel()
    let productsViewModel = ProductsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .backgroundColor
        setupViews()
        setupDelegation()
        registerCell()
        configureNavBar()
        specialProductsViewModel.fetchAllSpecialProducts()
    }
    //MARK: - func
    //MARK: - configureNavBar
    private func configureNavBar() {
        navigationItem.title = "Special Products"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem?.tintColor = .label
    }
    func setupViews(){
        view = specialProductsView
    }
    func setupDelegation(){
        specialProductsView.procustsCollectionView.delegate = self
        specialProductsView.procustsCollectionView.dataSource = self
        
        specialProductsViewModel.delegate = self
    }
    func registerCell(){
        specialProductsView.procustsCollectionView.register(SpecialProductCell.self, forCellWithReuseIdentifier: SpecialProductCell.identifier)
    }

}
//MARK: - procustsCollectionView delegate
extension SpecialProductViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specialProductsViewModel.allSpecialProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialProductCell.identifier, for: indexPath)as? SpecialProductCell else{return UICollectionViewCell()}
        cell.configCell(specialProductsViewModel.allSpecialProducts[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // did select prodcut...
       let selectedProductID = specialProductsViewModel.allSpecialProducts[indexPath.row].productId
            specialProductsViewModel.fetchSingleSpecialProduct(productID: selectedProductID)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: specialProductsView.procustsCollectionView.frame.width, height: specialProductsView.procustsCollectionView.frame.width/2 - 10)
        return size
    }
    //for animations
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
}
//MARK: - SpecialProductViewModel delegate
extension SpecialProductViewController: SpecialProductViewModelDelegate{
    func didFetchSingleProductSuccessfully(product: Product) {
        let productDetailVC = ProductDetailViewController(product: product)
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    func errorHapped(_ error: Error) {
        print(error.localizedDescription)
    }
    func didFetchAllSpecialProductsSuccessfully() {
        DispatchQueue.main.async {[weak self] in
            self?.specialProductsView.procustsCollectionView.reloadData()
        }
    }
    
}

