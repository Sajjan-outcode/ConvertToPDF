//
//  CustomCell.swift
//  ConvertScrollViewToPDF
//
//  Created by outcode  on 31/05/2023.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let image: UIImageView  = {
        let imageView =  UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(image)
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
    }
    
