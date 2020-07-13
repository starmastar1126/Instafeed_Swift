//
//  LoginCell.swift
//  audible
//
//  Created by Brian Voong on 9/17/16.
//  Copyright © 2016 Lets Build That App. All rights reserved.
//

import UIKit

protocol WalkThroughControllerDelegate: class {
    func GetstaryedTap()
    func signIntapped()
}

class LoginCell: UICollectionViewCell {
    
    weak var delegate: WalkThroughControllerDelegate?
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "w6")
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = UIColor.orange
        return imageView
    }()
    
    let belowView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    
    lazy var GetstartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexValue: 0x2E499A)
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleGetstarted), for: .touchUpInside)
        return button
    }()

    @objc func handleGetstarted() {
        delegate?.GetstaryedTap()
    }
    
    
    lazy var SignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexValue: 0xE7EAE5)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
      //  button.addTarget(self, action: #selector(signintap), for: .touchUpInside)
        button.addTarget(self, action: #selector(signintap), for: .touchUpInside)
        return button
    }()
    
    @objc func signintap(){
        delegate?.signIntapped()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(belowView)
        belowView.addSubview(textView)
        belowView.addSubview(GetstartedButton)
        belowView.addSubview(SignInButton)
        
           _ = logoImageView.anchor(safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: belowView.topAnchor, right: safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 300)[1]
        
        _ = belowView.anchor(logoImageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        _ = textView.anchor(belowView.topAnchor, left: belowView.leftAnchor, bottom: nil, right: belowView.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 100)
        
        
        _ = GetstartedButton.anchor(textView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 35, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
         _ = SignInButton.anchor(GetstartedButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 20, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        
        
        let color = UIColor(white: 0.2, alpha: 1)
        
        let attributedText = NSMutableAttributedString(string: "And that's not all", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor: color])  //title
        
        attributedText.append(NSAttributedString(string: "\n\n It's free to send your books to the people in your life. Every recipient's first book is on us.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: color]))  //msg
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let length = attributedText.string.count
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
        
        textView.attributedText = attributedText
    }
    
    override func layoutSubviews() {
        GetstartedButton.layer.cornerRadius = GetstartedButton.frame.height/2
        SignInButton.layer.cornerRadius = SignInButton.frame.height/2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

