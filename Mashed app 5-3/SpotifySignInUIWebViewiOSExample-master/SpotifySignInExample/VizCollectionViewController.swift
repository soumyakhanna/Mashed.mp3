//
//  VizCollectionViewController.swift
//  Displays past visualizations on onw screen
//
//  Created by Macbook Air on 5/10/21.
//  Copyright © 2021 John Codeos. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class VizCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viz2 = UIImage.gifImageWithName("viz2")
        let imageView = UIImageView(image: viz2)
        imageView.frame = CGRect(x: 5.0, y: 100.0, width: self.view.frame.size.width/3, height: self.view.frame.size.height/3)
        view.addSubview(imageView)
        
        let viz3 = UIImage.gifImageWithName("viz3")
        let _imageView = UIImageView(image: viz3)
        _imageView.frame = CGRect(x: 130.0, y: 100.0, width: self.view.frame.size.width/3, height: self.view.frame.size.height/3)
        view.addSubview(_imageView)
        
        let viz4 = UIImage.gifImageWithName("viz4")
        let __imageView = UIImageView(image: viz4)
        __imageView.frame = CGRect(x: 270.0, y: 100.0, width: self.view.frame.size.width/3, height: self.view.frame.size.height/3)
        view.addSubview(__imageView)
    }
    
}
