//
//  StartViewController.swift
//  SmartTeach Link
//
//  Created by Unique Consulting Firm on 09/12/2024.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //roundCorner(button: proceedButton)
        roundCornerView(image: image)
    }
    
    @IBAction func continueButtonTapped()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
}
