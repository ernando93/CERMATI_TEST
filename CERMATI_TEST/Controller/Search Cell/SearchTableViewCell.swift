//
//  SearchTableViewCell.swift
//  CERMATI_TEST
//
//  Created by Ernando Kasaluhe on 03/06/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    func configureCell(withData data: User) {
        setupViewContent(imageUrl: data.avatarUrl, name: data.login)
    }
}

//MARK: - Setup Content
extension SearchTableViewCell {
    func setupViewContent(imageUrl: String, name: String) {
        setupImageUser(withImageURL: imageUrl, andImageView: imageUser)
        setupLabelName(withName: name, andLabel: labelName)
    }
    
    func setupImageUser(withImageURL imageURL: String, andImageView imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.width / 2
        if imageURL != "" {
            let sdImageoption: SDWebImageOptions = .allowInvalidSSLCertificates
            imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "user"), options: sdImageoption) {(image, error, cahceType, nil) in
                
                if image == nil {
                    imageView.image = UIImage(named: "user")
                }
            }
        } else {
            imageView.image = UIImage(named: "user")
        }
    }
    
    func setupLabelName(withName name: String, andLabel label: UILabel) {
        label.text = name
    }
}
