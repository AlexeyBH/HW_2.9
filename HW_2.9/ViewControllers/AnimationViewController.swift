//
//  AnimationViewController.swift
//  HW_2.9
//
//  Created by Alexey Khestanov on 24.11.2021.
//

import UIKit
import Spring

class AnimationViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var animationView: SpringView!
    @IBOutlet var animationName: SpringLabel!
    @IBOutlet var animationDesc: SpringLabel!
    @IBOutlet var animationButton: SpringButton!
    
    
    // MARK: - Class Propeties
    var springParameters: SpringParameters = .init()
    var springPresetsLeft: [String] = []
    let springPresetsDefault: [String] = Spring.AnimationPreset.allCases.map { $0.rawValue }
    let springCurves: [String] = Spring.AnimationCurve.allCases.map { $0.rawValue }

    // MARK: - Class functions
    func updateAnimationTexts() {
        func round(_ arg: CGFloat) -> CGFloat {
            CGFloat(Int(arg * 1000)) / 1000
        }
        // Updating parameters for playing the next animation
        prepareForTheNextAnimation()
        // Updating labels, buttons etc..
        animationButton.setTitle("Play \"\(springParameters.preset)\"", for: .normal)
        animationName.text = springParameters.preset
        animationDesc.text = """
        Curve: \(springParameters.curve)
        Force: \(round(springParameters.force))
        Velocity: \(round(springParameters.velocity))
        Duration: \(round(springParameters.duration))
        """
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAnimationTexts()
    }
    

    // MARK: - Outlet actions
    @IBAction func playNextAnimation() {
        animationView.animation = springParameters.preset
        animationView.curve = springParameters.curve
        animationView.force = springParameters.force
        animationView.velocity = springParameters.velocity
        animationView.animate()
        updateAnimationTexts()
    }
    
}

// MARK: - Class extension
extension AnimationViewController {
    
    struct SpringParameters {
        var curve: String = ""
        var preset: String = ""
        var force: CGFloat = 1.0
        var duration: CGFloat = 3.0
        var velocity: CGFloat = 1.0
    }
    
    func prepareForTheNextAnimation() {
        if springPresetsLeft.isEmpty {
            springPresetsLeft = springPresetsDefault
        }
        if let randomPreset = springPresetsLeft.randomElement(),
           let randomCurve = springCurves.randomElement() {
            springParameters.preset = randomPreset
            springParameters.curve = randomCurve
            springParameters.force = CGFloat.random(in: 0.5...3)
            springParameters.velocity = CGFloat.random(in: 0.5...2.0)
            springParameters.duration = CGFloat.random(in: 0.6...3.0)
        }
    }
}
