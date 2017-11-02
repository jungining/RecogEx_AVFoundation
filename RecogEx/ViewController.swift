//
//  ViewController.swift
//  RecogEx
//
//  Created by YuJungin on 2017. 11. 2..
//  Copyright © 2017년 junginin. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) //프리뷰로 볼거니까 비디오 타입
            else { return }
        
        guard let input = try? AVCaptureDeviceInput(device : captureDevice) else { return }
        
        captureSession.addInput(input)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

