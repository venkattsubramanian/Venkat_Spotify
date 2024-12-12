//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.
//
import UIKit
import TinyConstraints

class FooterTabStackView: UIStackView{
    lazy var homeView: FooterTabView! = {
        let view = FooterTabView()
        view.defaultImage = .home
        view.selectedImage = .home
        view.didSelectTab = .home
        view.didSelectedTabItemAt = { tab in
            self.delegate?.didSelectedItem(at: tab)
        }
        view.height(.aspectHeight(50.0))
        view.tiletext = "Home"
        return view
    }()
    
    lazy var searchView: FooterTabView! = {
        let view = FooterTabView()
        view.defaultImage = .search
        view.selectedImage = .search
        view.didSelectTab = .search
        view.didSelectedTabItemAt = { tab in
            self.delegate?.didSelectedItem(at: tab)
        }
        view.height(.aspectHeight(50.0))
        view.tiletext = "Search"
        return view
    }()
    
    lazy var libraruryView: FooterTabView! = {
        let view = FooterTabView()
        view.defaultImage = .library
        view.selectedImage = .library
        view.didSelectTab = .librarury
        view.didSelectedTabItemAt = { tab in
            self.delegate?.didSelectedItem(at: tab)
        }
        view.height(.aspectHeight(50.0))
        view.tiletext = "Librauary"
        return view
    }()
    
    
    
    deinit{
        homeView = nil
        searchView = nil
        libraruryView = nil
        
    }
    
    weak var delegate: TabbarDidSelectedItemDelegate?
    weak var selectedTabDelegate: DidUpdateSelectedTabbarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.selectedTabDelegate = self
        self.addArrangedSubviews(homeView, searchView, libraruryView)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .center
        self.spacing = .aspectWidth(10)
        self.backgroundColor = .clear
    }
    
    required init(coder: NSCoder) {
        fatalError("")
    }
}

extension FooterTabStackView{
    func deselectEntireTab(){
        homeView.isSelected = false
        searchView.isSelected = false
        libraruryView.isSelected = false
    }
}

extension FooterTabStackView: DidUpdateSelectedTabbarDelegate{
    var footerStack: FooterTabStackView? {
        return self
    }
}

extension TabbarDidSelectedItemDelegate{
    func didSelectedItem(at item: FooterTabViewItems) {
        DispatchQueue.main.async {
            switch item {
            case .home:
                self.sourceController?.pushController(HomeViewController(), animated: false)
            case .search:
                self.sourceController?.pushController(SearchViewController(), animated: false)
            case .librarury:
                self.sourceController?.pushController(LibraryViewController(), animated: false)
                
            }
        }
    }
}


extension UIViewController {
    func pushController(_ viewController: UIViewController, animated: Bool! = true){
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}


protocol DidUpdateSelectedTabbarDelegate: NSObject{
    func selectTab(_ tab: FooterTabViewItems)
    var footerStack: FooterTabStackView? { get }
}

protocol TabbarDidSelectedItemDelegate: NSObject{
    func didSelectedItem(at item: FooterTabViewItems)
    var sourceController: BaseViewController? { get }
}

extension BaseViewController: TabbarDidSelectedItemDelegate{
    var sourceController: BaseViewController? {
        return self
    }
    @objc var baseViewController: Self {
        return self
    }
}

extension BaseViewController {
    func createDoneToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [flexSpace, doneButton]
        return toolbar
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}





class BaseViewController: UIViewController {
    
    lazy var footerTabBar: FooterTabBarView! = {
        let tabBar = FooterTabBarView()
        tabBar.tabEntryStackView.delegate = self
        return tabBar
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhiteColor
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
}

extension BaseViewController {
    func addFooterView(){
        self.view.addSubview(self.footerTabBar)
        footerTabBar.leading == view.leading
        footerTabBar.trailing == view.trailing
        footerTabBar.bottom == view.bottom
        let height = getDynamicHeight()
        footerTabBar.height(height)
    }
    func currentTabbar(_ selectedItem: FooterTabViewItems){
        footerTabBar.tabEntryStackView?.selectedTabDelegate?.selectTab(selectedItem)
    }
    
    func getDynamicHeight() -> CGFloat {
        return UIScreen.main.bounds.height >= 736 ? .aspectHeight(90) : .aspectHeight(60)
    }
    
}
