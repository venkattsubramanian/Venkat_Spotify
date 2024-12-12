//
//  libraryheaderView.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 11/12/24.
//


import Foundation
import UIKit

class QTopHomeHeaderView: UIView {
    
    
    private var playlists: [String] = []

    lazy var headerview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var ProfileImageView: UIImageView! = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "profile")
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = .ratioWidthBasedOniPhoneX(15)
        return view
    }()
    
    lazy var addLibrary: UIImageView! = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "addLibrary")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    private let libraryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Your Library"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let playListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Playlist"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.borderWidth = 0.5
        label.borderColor = .white
        label.layer.cornerRadius = .ratioWidthBasedOniPhoneX(15)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewsUIElements()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addLibraryTapped))
           addLibrary.addGestureRecognizer(tapGesture)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        addSubviewsUIElements()
    }
    
    @objc private func addLibraryTapped() {
        let bottomSheetVC = BottomSheetViewController()
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        if let parentVC = self.findViewController() {
            parentVC.present(bottomSheetVC, animated: true)
        }
    }





    private func addSubviewsUIElements() {
        
        addSubview(headerview)
        addSubview(ProfileImageView)
        addSubview(addLibrary)
        addSubview(libraryLabel)
        addSubview(playListLabel)
        
        ProfileImageView.top                  == top + .ratioHeightBasedOniPhoneX(20)
        ProfileImageView.leading              == leading + .ratioHeightBasedOniPhoneX(10)
        ProfileImageView.height               == .ratioHeightBasedOniPhoneX(30)
        ProfileImageView.width               == .ratioHeightBasedOniPhoneX(30)
        
        libraryLabel.top                  == ProfileImageView.top + .ratioHeightBasedOniPhoneX(5)
        libraryLabel.leading              == ProfileImageView.trailing + .ratioHeightBasedOniPhoneX(10)
        
        playListLabel.top                  == ProfileImageView.bottom + .ratioHeightBasedOniPhoneX(20)
        playListLabel.leading              == leading + .ratioHeightBasedOniPhoneX(10)
        playListLabel.height               == .ratioHeightBasedOniPhoneX(30)
        playListLabel.width               == .ratioHeightBasedOniPhoneX(90)

        
        addLibrary.top                  == top + .ratioHeightBasedOniPhoneX(25)
        addLibrary.trailing             == trailing
        addLibrary.height               == .ratioHeightBasedOniPhoneX(25)
        addLibrary.width               == .ratioHeightBasedOniPhoneX(25)

    }
    
}

extension UIView {
    func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

