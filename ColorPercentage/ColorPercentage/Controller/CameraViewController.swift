//
//  CameraViewController.swift
//  ColorPercentage
//
//  Created by Mac on 07/06/2021.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    var captureSession = AVCaptureSession()
    var camera: AVCaptureDevice?
    var cameraPreviewlayer: AVCaptureVideoPreviewLayer?
    var updatedWidth  = CGFloat()
    var updatedHeight = CGFloat()
    let stackView = UIStackView()
    let hedlineLabel = UILabel()
    var colorDistribution1 = UILabel()
    var colorDistributionPercenteg1 = UILabel()
    var colorDistribution2 = UILabel()
    var colorDistributionPercenteg2 = UILabel()
    var colorDistribution3 = UILabel()
    var colorDistributionPercenteg3 = UILabel()
    var colorDistribution4 = UILabel()
    var colorDistributionPercenteg4 = UILabel()
    var colorDistribution5 = UILabel()
    var colorDistributionPercenteg5 = UILabel()
    let squerView1 = UIImageView()
    let squerView2 = UIImageView()
    let squerView3 = UIImageView()
    let squerView4 = UIImageView()
    let squerView5 = UIImageView()
    var stackViewWidth = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupInput()
        setupPreviewLayer()
        startRunningCaptureSession()
        textAtribiuts()
        updateText()
    }
    
    //update the size of the button if you switch  lanscape/portrait
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateFrame()
    }
    //update the width and height to fit all kinds of iphones
    func updateFrame(){
        var width = CGFloat(18)
        updatedWidth = view.bounds.width
        updatedHeight = view.bounds.height
        stackViewWidth = updatedWidth/4.2
        let height = updatedHeight/7.6
        //check the orientation of the devise and move the video to the corrent state
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft{
            squersConstraints(constrantsOn: false, width: 0, squerHeght: 0)
            width = 66
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight{
            squersConstraints(constrantsOn: false, width: 0, squerHeght: 0)
            width = 66
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.portrait{
            cameraPreviewlayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            squersConstraints(constrantsOn: false, width: 0, squerHeght: 0)
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown{
            cameraPreviewlayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
            squersConstraints(constrantsOn: false, width: 0, squerHeght: 0)
        }
        
        //update the frame of the camera
        cameraPreviewlayer?.frame = CGRect(x: 0, y: 0, width: updatedWidth, height: updatedHeight)
        //update the size of the stackview
        stackView.frame = CGRect(x: updatedWidth-stackViewWidth, y: 0, width: stackViewWidth, height: updatedHeight)
        //update the squers in the stack view
        squersConstraints(constrantsOn: true, width: width, squerHeght: height)
        collorStackView()
        colorDistributionPercenteg1.frame = CGRect(x: 5, y: 5, width: stackViewWidth-width, height: height-10)
        colorDistributionPercenteg2.frame = CGRect(x: 5, y: 5, width: stackViewWidth-width, height: height-10)
        colorDistributionPercenteg3.frame = CGRect(x: 5, y: 5, width: stackViewWidth-width, height: height-10)
        colorDistributionPercenteg4.frame = CGRect(x: 5, y: 5, width: stackViewWidth-width, height: height-10)
        colorDistributionPercenteg5.frame = CGRect(x: 5, y: 5, width: stackViewWidth-width, height: height-10)
    }
    //set the stackview attribiution
    func collorStackView(){
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        stackView.spacing = 4.0
        stackView.backgroundColor = .black
        //set the squers images befure adding them to the stackview
        setSquers()
        //adding all the squers and the text to the stackview by order
        stackView.addArrangedSubview(hedlineLabel)
        stackView.addArrangedSubview(squerView1)
        stackView.addArrangedSubview(colorDistribution1)
        stackView.addArrangedSubview(squerView2)
        stackView.addArrangedSubview(colorDistribution2)
        stackView.addArrangedSubview(squerView3)
        stackView.addArrangedSubview(colorDistribution3)
        stackView.addArrangedSubview(squerView4)
        stackView.addArrangedSubview(colorDistribution4)
        stackView.addArrangedSubview(squerView5)
        stackView.addArrangedSubview(colorDistribution5)
    }
    //set and update the constrains of the squers inside the stackview
    func squersConstraints(constrantsOn: Bool,width:CGFloat,squerHeght:CGFloat){
        
        switch constrantsOn {
        case true:
            squerView1.widthAnchor.constraint(equalToConstant: stackViewWidth-width).isActive = true
            squerView1.heightAnchor.constraint(equalToConstant: squerHeght).isActive = true
            squerView2.widthAnchor.constraint(equalToConstant: stackViewWidth-width).isActive = true
            squerView2.heightAnchor.constraint(equalToConstant: squerHeght).isActive = true
            squerView3.widthAnchor.constraint(equalToConstant: stackViewWidth-width).isActive = true
            squerView3.heightAnchor.constraint(equalToConstant: squerHeght).isActive = true
            squerView4.widthAnchor.constraint(equalToConstant: stackViewWidth-width).isActive = true
            squerView4.heightAnchor.constraint(equalToConstant: squerHeght).isActive = true
            squerView5.widthAnchor.constraint(equalToConstant: stackViewWidth-width).isActive = true
            squerView5.heightAnchor.constraint(equalToConstant: squerHeght).isActive = true
        case false:
            //need to remuve constrains befoure adding new constraint
            squerView1.removeConstraints(squerView1.constraints)
            squerView2.removeConstraints(squerView2.constraints)
            squerView3.removeConstraints(squerView3.constraints)
            squerView4.removeConstraints(squerView4.constraints)
            squerView5.removeConstraints(squerView5.constraints)
        }
    }
    //add colored squers to the stackview
    func setSquers(){
        squerView1.translatesAutoresizingMaskIntoConstraints = false
        squerView1.backgroundColor = .gray
        squerView1.layer.borderWidth = 2.5
        squerView1.layer.borderColor = UIColor.white.cgColor
        squerView2.translatesAutoresizingMaskIntoConstraints = false
        squerView2.backgroundColor = .darkGray
        squerView2.layer.borderWidth = 2.5
        squerView2.layer.borderColor = UIColor.white.cgColor
        squerView3.translatesAutoresizingMaskIntoConstraints = false
        squerView3.backgroundColor = .brown
        squerView3.layer.borderWidth = 2.5
        squerView3.layer.borderColor = UIColor.white.cgColor
        squerView4.translatesAutoresizingMaskIntoConstraints = false
        squerView4.backgroundColor = .orange
        squerView4.layer.borderWidth = 2.5
        squerView4.layer.borderColor = UIColor.white.cgColor
        squerView5.translatesAutoresizingMaskIntoConstraints = false
        squerView5.backgroundColor = .blue
        squerView5.layer.borderWidth = 2.5
        squerView5.layer.borderColor = UIColor.white.cgColor
        //add the persentege text to the image square
        squerView1.addSubview(colorDistributionPercenteg1)
        squerView2.addSubview(colorDistributionPercenteg2)
        squerView3.addSubview(colorDistributionPercenteg3)
        squerView4.addSubview(colorDistributionPercenteg4)
        squerView5.addSubview(colorDistributionPercenteg5)
    }
    
    //set all the text attribiuts
    func textAtribiuts(){
        hedlineLabel.translatesAutoresizingMaskIntoConstraints = false
        hedlineLabel.text = "חלוקת צבעים"
        hedlineLabel.textColor = .white
        hedlineLabel.textAlignment = .center
        hedlineLabel.font = .boldSystemFont(ofSize: 22)
        hedlineLabel.adjustsFontSizeToFitWidth = true
        colorDistribution1.translatesAutoresizingMaskIntoConstraints = false
        colorDistribution1.textColor = .white
        colorDistribution1.textAlignment = .left
        colorDistribution1.font = UIFont(name: "ArialHebrew", size: 15)
        colorDistribution1.adjustsFontSizeToFitWidth = true
        colorDistributionPercenteg1.textColor = .white
        colorDistributionPercenteg1.textAlignment = .center
        colorDistributionPercenteg1.font = UIFont(name: "ArialHebrew-Bold", size: 36)
        colorDistribution2.translatesAutoresizingMaskIntoConstraints = false
        colorDistribution2.textColor = .white
        colorDistribution2.textAlignment = .left
        colorDistribution2.adjustsFontSizeToFitWidth = true
        colorDistribution2.font = UIFont(name: "ArialHebrew", size: 15)
        colorDistributionPercenteg2.textColor = .white
        colorDistributionPercenteg2.textAlignment = .center
        colorDistributionPercenteg2.font = UIFont(name: "ArialHebrew-Bold", size: 36)
        colorDistribution3.translatesAutoresizingMaskIntoConstraints = false
        colorDistribution3.textColor = .white
        colorDistribution3.textAlignment = .left
        colorDistribution3.font = UIFont(name: "ArialHebrew", size: 15)
        colorDistributionPercenteg3.textColor = .white
        colorDistributionPercenteg3.textAlignment = .center
        colorDistributionPercenteg3.font = UIFont(name: "ArialHebrew-Bold", size: 36)
        colorDistribution4.translatesAutoresizingMaskIntoConstraints = false
        colorDistribution4.textColor = .white
        colorDistribution4.textAlignment = .left
        colorDistribution4.font = UIFont(name: "ArialHebrew", size: 15)
        colorDistributionPercenteg4.textColor = .white
        colorDistributionPercenteg4.textAlignment = .center
        colorDistributionPercenteg4.font = UIFont(name: "ArialHebrew-Bold", size: 36)
        colorDistribution5.translatesAutoresizingMaskIntoConstraints = false
        colorDistribution5.textColor = .white
        colorDistribution5.textAlignment = .left
        colorDistribution5.font = UIFont(name: "ArialHebrew", size: 15)
        colorDistributionPercenteg5.textColor = .white
        colorDistributionPercenteg5.textAlignment = .center
        colorDistributionPercenteg5.font = UIFont(name: "ArialHebrew-Bold", size: 36)
    }
    //update the text evry time its get called
    func updateText(){
        colorDistribution1.text = "300"
        colorDistribution2.text = "300"
        colorDistribution3.text = "300"
        colorDistribution4.text = "300"
        colorDistribution5.text = "300"
        colorDistributionPercenteg1.text = "30%"
        colorDistributionPercenteg2.text = "35%"
        colorDistributionPercenteg3.text = "32%"
        colorDistributionPercenteg4.text = "10%"
        colorDistributionPercenteg5.text = "70%"
    }
    //
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        let availableDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: .back)
        //if you want to add later front camera
        let devices = availableDevice.devices //back or front
        //check if front camera or back
        for device in devices {
            if device.position == AVCaptureDevice.Position.back{
                camera = device
            }
        }
    }
    
    //set the divice input
    func setupInput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: camera!)
            captureSession.addInput(captureDeviceInput)
        }
        catch{
            print(error)
        }
    }
    //
    func setupPreviewLayer(){
        cameraPreviewlayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewlayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(cameraPreviewlayer!, at: 0)
    }
    //running the camera
    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
}
