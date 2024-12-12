//
//  HomeViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 10/12/24.
//
import UIKit
import TinyConstraints

class FooterTabView: UIView{
    lazy  var tabbarImage = UIImageView()
    lazy var tabbarTittle = createLabel.setLabel(font: .systemFont(ofSize: 12), textColor: .appWhiteColor, textAlignment: .center, text: tiletext)
    
    var didSelectedTabItemAt: ((FooterTabViewItems) -> ())? = nil
    var didSelectTab: FooterTabViewItems! {
        didSet {
            self.updateTabImage()
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            self.updateTabImage()
            if isSelected {
                self.tabbarImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                tabbarTittle.textColor = .Menu
                tabbarImage.tintColor = .Menu
            } else {
                self.tabbarImage.transform = .identity
                tabbarTittle.textColor = .white
                tabbarImage.tintColor = .white
            }
        }
    }
    
    var defaultImage: UIImage?
    var selectedImage: UIImage?
    var tiletext: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tabbarImage.tintColor = .white
        tabbarImage.contentMode = .scaleAspectFit
        self.addTapGesture(target: self, action: #selector(self.tabbarItemSelectedAction))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setViewAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

extension FooterTabView{
    func setViewAndConstraints(){
        addSubviews(tabbarImage, tabbarTittle)
        tabbarImage.height(.aspectHeight(20))
        tabbarImage.width(.aspectWidth(20))
        tabbarImage.top == self.top + .aspectHeight(3)
        tabbarImage.centerX == self.centerX
        tabbarTittle.top == tabbarImage.bottom + .aspectHeight(5)
        tabbarTittle.leading == self.leading
        tabbarTittle.trailing == self.trailing
        tabbarTittle.height == .aspectHeight(20)
    }
    func updateTabImage() {
        if isSelected, let selectedImage = selectedImage {
            tabbarImage.image = selectedImage.withRenderingMode(.alwaysTemplate)
        } else if let normalImage = defaultImage {
            tabbarImage.image = normalImage.withRenderingMode(.alwaysTemplate)
        }
    }
}
extension FooterTabView{
    @objc func tabbarItemSelectedAction(){
        self.didSelectedTabItemAt?(self.didSelectTab)
    }
}
extension UIView {
    func addTapGesture(target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
}

extension UIView{
    
    func addSubviews(_ views: UIView...){
        views.forEach({addSubview($0)})
    }
    
    func removeSubviews(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func roundCorners(){
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.width / 2;
        self.clipsToBounds = true
    }
    
    func roundCorners(_ radius:CGFloat){
        self.layoutIfNeeded()
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

extension UIView {
    func addShadow(shadowColor: CGColor  = UIColor.logincolor.cgColor,shadowOffset: CGSize  = CGSize(width: 1.0, height: 2.0),shadowOpacity: Float  = 0.5,shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            if let stackView = self as? UIStackView {
                stackView.addArrangedSubview(view)
            } else {
                fatalError("View is not a UIStackView")
            }
        }
    }
    
    func showAnimation(set value: CGFloat, _ completionBlock: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: value, y: value)
            }) {  (done) in
                UIView.animate(withDuration: 0.1,
                               delay: 0,
                               options: .curveLinear,
                               animations: { [weak self] in
                    self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                }) { [weak self] (_) in
                    self?.isUserInteractionEnabled = true
                    completionBlock?()
                }
            }
        }
    }
    
    func setUpCustomShadow(CornerRadius: CGFloat, shadowOffsetWidth: Int = 6, shadowOffsetHeight: Int = 6) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        self.layer.shadowRadius = 15.0
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: .aspectHeight(CornerRadius))
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.zPosition = 4.0
    }
}
