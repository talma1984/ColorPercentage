//
//  ViewController.swift
//  ColorPercentage
//
//  Created by Mac on 07/06/2021.
//

import UIKit

class OpeningViewController: UIViewController {

    let backgroundImageView = UIImageView()
    let cameraButton = UIButton()
    var updatedWidth  = CGFloat()
    var updatedHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFrame()
        setBackground()
    }
    
    //update the size of the button if you switch  lanscape/portrait
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFrame()
    }
    
    //update the width and the button will fit all kinds of iphones
    func updateFrame(){
        updatedWidth = view.bounds.width
        updatedHeight = view.bounds.height
        cameraButton.frame = CGRect(x: (updatedWidth/2)-80, y: (updatedHeight/2)-80, width: 160, height: 160)
    }
    
    //set the background image and the button that start's the camera
    func setBackground(){
        backgroundImageView.image = UIImage(named: "collors2")
        backgroundImageView.contentMode = .scaleToFill
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.isUserInteractionEnabled = true
         
        cameraButton.setImage(UIImage(named: "cameraButton"), for: UIControl.State.normal)
        cameraButton.contentMode = .scaleToFill
        backgroundImageView.addSubview(cameraButton)
        cameraButton.clipsToBounds = true
        cameraButton.addTarget(self, action:#selector(cameraButtonClicked), for: .touchUpInside)
    }
    
    //segue into the camera view controller
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "cameraSegue", sender: self)
    }
}

