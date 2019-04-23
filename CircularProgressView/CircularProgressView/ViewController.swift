//
//  ViewController.swift
//  CircularProgressView
//
//  Created by Bartosz Dolewski on 15/03/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var topProgressBarView: CircularProgressView!
    @IBOutlet var middleProgressBarView: CircularProgressView!
    @IBOutlet var bottomProgressBarView: CircularProgressView!
    
    let shapeLayer = CAShapeLayer()
    
    private lazy var circularPath: UIBezierPath = {
        return UIBezierPath(arcCenter: .zero,
                            radius: 100,
                            startAngle:  0,
                            endAngle: 2 * .pi,
                            clockwise: true)
    }()
    
    private lazy var trackLayer: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.darkGray.cgColor
        trackLayer.lineWidth = 10.0
        trackLayer.lineCap = .round
        trackLayer.position = self.view.center
        
        return trackLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        topProgressBarView.setProgress(to: 0.33, animated: true)
        middleProgressBarView.setProgress(to: 0.7, animated: true)
        bottomProgressBarView.setProgress(to: 1.21, animated: true)
        
        topProgressBarView.text = "Today"
        middleProgressBarView.text = "Week"
        bottomProgressBarView.text = "Month"
    }
}
