//
//  StartScreenViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBOutlet weak var hangmanImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var imageList = [UIImage]()
        
        for i in 0...7 {
            let imageName = "hangman\(i).png"
            let image = UIImage(named:imageName)
            imageList.append(image!)
        }
        
        self.hangmanImage.animationImages = imageList
        self.hangmanImage.animationDuration = 4.0
        self.hangmanImage.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
