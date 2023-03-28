//
//  OnboardingViewController.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit
import SnapKit

 class OnboardingController: UIViewController {
    //MARK: - Properties
    private let onboardingView = OnboardingView()
    //MARK: -  ViewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavBar()
        collectionCellRegister()
        setupDelegates()
    }
    //MARK: - ConfigureViewController
    private func configureViewController() {
        view = onboardingView
        onboardingView.delegate = self
    }
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    //MARK: - Register Custom Collection Cell
    private func collectionCellRegister() {
        onboardingView.collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        onboardingView.collection.delegate = self
        onboardingView.collection.dataSource = self
    }
}
//MARK: - CollectionView Methods
extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingView.slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = onboardingView.collection.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else { return UICollectionViewCell()}
        cell.configure(data: onboardingView.slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onboardingView.collection.frame.width, height: onboardingView.collection.frame.height)
    }
}

//MARK: - OnboardingViewInterface Methods
extension OnboardingController: OnboardingViewDelegate{
    func onboardingView(_ view: OnboardingView, contiuneButtonTapped button: UIButton) {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    func onboardingView(_ view: OnboardingView, skipButtonTapped button: UIButton) {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    func onboardingView(_ view: OnboardingView, signInButtonTapped button: UIButton) {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
}
//MARK: - ScrollView Method
extension OnboardingController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width
        onboardingView.currentPage = Int(scrollView.contentOffset.x / witdh)
        print(scrollView.contentOffset.x) // 300
        print(scrollView.contentOffset.x / witdh) // 300/300 = 1 -> page 1
    }
}
