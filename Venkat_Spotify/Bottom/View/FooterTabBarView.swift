//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.
//

import UIKit
import TinyConstraints

class FooterTabBarView: UIView{
    
    lazy var backGroundView: UIView! = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 1
        return view
        
    }()
    lazy var tabEntryStackView: FooterTabStackView! = {
        let stack = FooterTabStackView()
        return stack
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView(){
        addSubviews(backGroundView)
        backGroundView.addSubview(tabEntryStackView)
    }
    
    func addConstraints(){
        backGroundView.top == self.top
        backGroundView.leading == self.leading
        backGroundView.trailing == self.trailing
        backGroundView.bottom == self.bottom
        tabEntryStackView.top == backGroundView.top + .aspectHeight(5)
        tabEntryStackView.leading == backGroundView.leading
        tabEntryStackView.trailing == backGroundView.trailing
        tabEntryStackView.height == .aspectHeight(50)
    }
}
