//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.
//

import Foundation

extension DidUpdateSelectedTabbarDelegate{
    func selectTab(_ tab: FooterTabViewItems){
        self.footerStack?.deselectEntireTab()
        switch tab {
        case .home:
            self.footerStack?.homeView.isSelected = true
        case .search:
            self.footerStack?.searchView.isSelected = true
        case .librarury:
            self.footerStack?.libraruryView.isSelected = true
       
        }
    }
}

enum FooterTabViewItems{
    case home
    case search
    case librarury
}
