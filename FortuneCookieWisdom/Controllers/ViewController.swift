//
//  ViewController.swift
//  FortuneCookieWisdom
//
//  Created by Fernando Bulnes Garrorena on 11/17/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var fortuneLabel: UILabel!
    @IBOutlet weak var cookieButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    
    // MARK: - Properties
    let fortuneProvider = FortuneProvider()
    
    enum CookieState {
        case whole
        case cracked
        case broken
        case revealed
    }
    
    var currentState: CookieState = .whole
    var tapCount = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
        setupInitialState()
    }
    
    // MARK: - Visual Design
    func setupDesign() {
        let backgroundImageView = UIImageView(image: UIImage(named: "background-pattern"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.50
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(backgroundImageView, at: 0)
        
        cookieButton.layer.shadowColor = UIColor.black.cgColor
        cookieButton.layer.shadowOpacity = 0.3
        cookieButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        cookieButton.layer.shadowRadius = 15
        cookieButton.layer.masksToBounds = false
        
        fortuneLabel.layer.shadowColor = UIColor.white.cgColor
        fortuneLabel.layer.shadowOpacity = 0.8
        fortuneLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        fortuneLabel.layer.shadowRadius = 2
        fortuneLabel.layer.masksToBounds = false
    }
    
    // MARK: - Initital Logic Configuration
    func setupInitialState() {
        currentState = .whole
        tapCount = 0
        
        if let label = fortuneLabel {
            label.alpha = 1.0
            label.text = "Tap 3 times to crack the cookie..."
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            label.transform = .identity
        }
        
        if let button = cookieButton {
            let wholeImage = UIImage(named: "cookie_whole")
            button.setImage(wholeImage, for: .normal)
            
            button.imageView?.contentMode = .scaleAspectFit
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
        }
        
        if let heart = heartButton {
            heart.setImage(UIImage(systemName: "heart"), for: .normal)
            heart.tintColor = .systemRed
            heart.alpha = 0.5
            heart.isEnabled = false
        }
    }

    // MARK: - Acción Principal
    @IBAction func cookieTapped(_ sender: UIButton) {
        animateButtonPress()
        
        switch currentState {
        case .whole:
            handleWholeState()
        case .cracked:
            handleCrackedState()
        case .broken:
            revealFortune()
        case .revealed:
            resetApp()
        }
    }
    
    // MARK: - FASE 1: Romper Cáscara (3 toques)
    func handleWholeState() {
        tapCount += 1
        let tapsNeeded = 3
        
        if tapCount < tapsNeeded {
            shakeCookie()
            let remaining = tapsNeeded - tapCount
            fortuneLabel.text = "Hard shell... \(remaining) more taps!"
            fortuneLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        } else {
            currentState = .cracked
            tapCount = 0
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            UIView.transition(with: cookieButton, duration: 0.3, options: .transitionCrossDissolve) {
                self.cookieButton.setImage(UIImage(named: "cookie_cracked"), for: .normal)
            }
            fortuneLabel.text = "It cracked! Keep tapping..."
        }
    }
    
    // MARK: - FASE 2: Abrir Galleta (3 toques más)
    func handleCrackedState() {
        tapCount += 1
        let tapsNeeded = 3
        
        if tapCount < tapsNeeded {
            shakeCookie()
            fortuneLabel.text = "Almost open... Tap harder! (\(tapCount)/3)"
        } else {
            currentState = .broken
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            UIView.transition(with: cookieButton, duration: 0.3, options: .transitionCrossDissolve) {
                self.cookieButton.setImage(UIImage(named: "cookie_broken"), for: .normal)
            }
            fortuneLabel.text = "It's open! Tap to read your Fortune."
            fortuneLabel.textColor = .systemOrange
            fortuneLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
    
    // MARK: - FASE 3: Revelar Fortuna
    func revealFortune() {
        currentState = .revealed
        let fortune = fortuneProvider.getRandomFortune()
        
        fortuneLabel.alpha = 0
        fortuneLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        fortuneLabel.text = "\"\(fortune.text)\""
        fortuneLabel.textColor = .black
        fortuneLabel.font = UIFont(name: "Georgia-Italic", size: 26) ?? UIFont.italicSystemFont(ofSize: 26)
        
        if let heart = heartButton {
            heart.setImage(UIImage(systemName: "heart"), for: .normal)
            heart.isEnabled = true
            heart.alpha = 1.0
            
            UIView.animate(withDuration: 0.5, delay: 0.5, options: [.autoreverse, .repeat], animations: {
                heart.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
            self.fortuneLabel.alpha = 1
            self.fortuneLabel.transform = .identity
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.heartButton.layer.removeAllAnimations()
                self.heartButton.transform = .identity
                
                let attrString = NSMutableAttributedString(string: "\"\(fortune.text)\"")
                let restartText = NSAttributedString(string: "\n\n(Tap cookie to restart)", attributes: [
                    .font: UIFont.systemFont(ofSize: 14, weight: .light),
                    .foregroundColor: UIColor.darkGray
                ])
                attrString.append(restartText)
                
                UIView.transition(with: self.fortuneLabel, duration: 0.3, options: .transitionCrossDissolve) {
                    self.fortuneLabel.attributedText = attrString
                }
            }
        }
    }
    
    func resetApp() {
        UIView.animate(withDuration: 0.5) {
            self.fortuneLabel.alpha = 0
            self.heartButton.alpha = 0.5
        } completion: { _ in
            self.setupInitialState()
            UIView.animate(withDuration: 0.5) {
                self.fortuneLabel.alpha = 1
            }
        }
    }
    
    // MARK: - Acción Guardar
    @IBAction func saveFavoriteTapped(_ sender: UIButton) {
        if currentState == .revealed, let text = fortuneLabel.text {
            
            let cleanText = text.components(separatedBy: "\n\n").first?
                                .replacingOccurrences(of: "\"", with: "") ?? text
            
            if !FortuneProvider.favoriteFortunes.contains(where: { $0.text == cleanText }) {
                let newFortune = Fortune(text: cleanText, category: "Saved Wisdom", isFavorite: true)
                FortuneProvider.favoriteFortunes.append(newFortune)
            }
            
            sender.layer.removeAllAnimations()
            sender.transform = .identity
            sender.tintColor = .systemRed
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            }) { _ in
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
                    sender.transform = .identity
                }, completion: nil)
            }
        }
    }

    // MARK: - Animaciones Táctiles
    func animateButtonPress() {
        UIView.animate(withDuration: 0.1, animations: {
            self.cookieButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.cookieButton.transform = .identity
            }
        }
    }
    
    func shakeCookie() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.5
        animation.values = [-8.0, 8.0, -6.0, 6.0, -4.0, 4.0, 0.0 ]
        cookieButton.layer.add(animation, forKey: "shake")
    }
}
