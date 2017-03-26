//
//  ViewController.swift
//  MOPhotoPreviewer
//
//  Created by moxiaohao on 2017/3/24.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTap))
        image1?.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(imageTap2))
        image2?.addGestureRecognizer(tap2)
        
    }
    
    func imageTap() {
        let photoView = MOPhotoPreviewer()
        photoView.preview(fromImageView: image1, container: self.view)
    }
    
    func imageTap2() {
        let photoView = MOPhotoPreviewer()
        photoView.preview(fromImageView: image2, container: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

