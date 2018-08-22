//
//  ViewController.swift
//  ImageTransparentApp
//
//  Created by Naraki on 8/22/18.
//  Copyright © 2018 i-enter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func transparentButtonTapped(_ sender: UIButton) {
        let transparentedImage = targetImageView.image?.imageByMakingWhiteBackgroundTransparent()
        targetImageView.image = transparentedImage
    }

}

extension UIImage {
    func imageByMakingWhiteBackgroundTransparent() -> UIImage? {

        let image = UIImage(data: UIImageJPEGRepresentation(self, 1.0)!)!
        let rawImageRef: CGImage = image.cgImage!

        let colorMasking: [CGFloat] = [222, 255, 222, 255, 222, 255]
        UIGraphicsBeginImageContext(image.size);

        let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking)
        UIGraphicsGetCurrentContext()?.translateBy(x: 0.0,y: image.size.height)
        UIGraphicsGetCurrentContext()?.scaleBy(x: 1.0, y: -1.0)
        UIGraphicsGetCurrentContext()?.draw(maskedImageRef!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return result

    }
}
