//
//  ViewController.swift
//  RecogEx
//
//  Created by YuJungin on 2017. 11. 2..
//  Copyright © 2017년 junginin. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController ,AVCaptureVideoDataOutputSampleBufferDelegate{
    
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) //프리뷰로 볼거니까 비디오 타입
            else { return }
        
        guard let input = try? AVCaptureDeviceInput(device : captureDevice) else { return }
        
        
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session : captureSession)
        
        cameraView.layer.addSublayer(previewLayer)
        
        previewLayer.frame = cameraView.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label : "videoOutput"))
        captureSession.addOutput(dataOutput)
        
    
        
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) { //프리뷰 뜨는거
        guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}//픽셀버퍼로 변경
        
        guard let model = try? VNCoreMLModel(for : Resnet50().model
         
        )   else { return }
        
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            print(finishedReq.results)
            
            guard let results = finishedReq.results as? [VNClassificationObservation]
            else { return }
          
            guard let firstObservation = results.first else { return }
            
            print(firstObservation.identifier, firstObservation.confidence)
            
            try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        }
    }
}

