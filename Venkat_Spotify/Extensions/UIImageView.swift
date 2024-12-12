//
//  UIImageView.swift
//  Carspa
//
//  Created by Achu Anil's MacBook Pro on 30/04/24.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(
        from urlString: String?,
        placeholder: UIImage? = nil,
        forceRefresh: Bool = false,
        retryCount: Int = 3,
        timeoutInterval: TimeInterval = 15,
        completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil
    ) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        self.kf.indicatorType = .activity
        
        var options: KingfisherOptionsInfo = [
            .transition(.fade(0.3)),
            .cacheOriginalImage,
            .downloadPriority(0.8)
        ]
        
        if forceRefresh {
            options.append(.forceRefresh)
        }
        
        options.append(.retryStrategy(
            DelayRetryStrategy(maxRetryCount: retryCount, retryInterval: .seconds(3))
        ))
        
        let downloader = KingfisherManager.shared.downloader
        downloader.downloadTimeout = timeoutInterval
        
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options
        ) { result in
            switch result {
            case .success(let imageResult):
                print("Image loaded successfully from: \(urlString)")
                completion?(.success(imageResult))
                
            case .failure(let error):
                print("Failed to load image: \(error.localizedDescription)")
                self.handleImageLoadingError(error)
                completion?(.failure(error))
            }
        }
    }
    
    private func handleImageLoadingError(_ error: KingfisherError) {
        switch error {
        case .requestError(let requestError):
            print("Request error occurred: \(requestError)")
        case .responseError(let responseError):
            print("Response error occurred: \(responseError)")
        case .cacheError(let cacheError):
            print("Cache error occurred: \(cacheError)")
        default:
            print("Other error occurred: \(error.localizedDescription)")
        }
    }
}


class createImageView {
    
    static func setImageView(withContentMode contentMode: UIView.ContentMode = .scaleAspectFit,
                             tintColor: UIColor? = nil,
                             systemImageName: String? = nil,
                             namedImage: String? = nil,
                             cornerRadius: CGFloat = 0,
                             maskedCorners: CACornerMask = [],
                             backgroundcolor: UIColor? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
        imageView.tintColor = tintColor
        if let systemImageName = systemImageName {
            imageView.image = UIImage(systemName: systemImageName)
        } else if let namedImage = namedImage {
            imageView.image = UIImage(named: namedImage)
        }
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.maskedCorners = maskedCorners
        imageView.backgroundColor = backgroundcolor
        return imageView
    }
}

extension UIImage {
   static let deleteimage = UIImage(systemName: "xmark")
    static let signInImg =   UIImage.init(named: "SignInBg")
    static let emptyOrderImg = UIImage(named: "empty_orders")
    static let selectLocation = UIImage(systemName: "mappin.and.ellipse")
    static let Phone = UIImage(named: "Phone")
    static let leftArrow = UIImage(systemName: "arrow.left")
    static let email = UIImage(named: "Email")
    static let signUpImg = UIImage(named: "SignupBg")
    static let arrowDown = UIImage(systemName: "chevron.down")
    static let checkBox = UIImage(systemName: "square")
    static let selectedcheckBox =  UIImage(systemName: "checkmark.square.fill")
    static let homeIcon = UIImage(named: "icon-home")
    static let locationIcon =  UIImage(named: "icon_location")
    static let rewardsIcon =   UIImage(named: "icon-rewards")
    static let accountIcon = UIImage(named: "icon-account")
    static let menuIcon =   UIImage(named: "icon-more")
    
    
    
    static let carspaLogo = UIImage(named: "CarspaLogo")
    
    static let noPlans = UIImage(named: "no_plans")
    
    static let checkmarkRight = UIImage(systemName: "checkmark.square.fill")
    
    
    static let search =   UIImage(named: "Search")
    static let home =   UIImage(named: "home")
    static let library =   UIImage(named: "library")
}

extension UIImage {
    static let shareLightMode: UIImage? = UIImage(named: "shareB")
    static let shareDarkMode: UIImage? = UIImage(named: "shareA")
}
