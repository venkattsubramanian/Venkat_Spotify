//
//  AddPlaylistViewController.swift
//  Venkat_Spotify
//
//  Created by venkat subramaian on 11/12/24.
//

import Foundation
import UIKit


class AddPlaylistViewController: BaseViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Name your playlist."
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let folderTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.placeholder = "My first library"
        textField.borderStyle = .none // Remove the default border style
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 40 - 1, width: UIScreen.main.bounds.width - 32, height: 2)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.layer.addSublayer(bottomLine)
        
        return textField
    }()

    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupConstraints()
        folderTextField.inputAccessoryView = self.createDoneToolbar()

    }
    
    
    @objc func backBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(folderTextField)
        view.addSubview(confirmButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            folderTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            folderTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            folderTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            folderTextField.heightAnchor.constraint(equalToConstant: 40),
            
            confirmButton.topAnchor.constraint(equalTo: folderTextField.bottomAnchor, constant: 40),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 120),
            confirmButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func confirmTapped() {
        guard let playlistName = folderTextField.text, !playlistName.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter a playlist name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let dbHandler = DBHandler()
            dbHandler.insertPlaylist(name: playlistName)
        
        let yourLibraryVC = YourLibraryViewController(playlistName: playlistName)
        let navigationController = UINavigationController(rootViewController: yourLibraryVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }



}
