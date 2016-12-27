//
//  ViewController.swift
//  ImageRecognizer
//
//  Created by user on 12/24/16.
//  Copyright © 2016 alex.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var paintView: PaintView!
    
    private var photoImage: UIImage?
    private var picker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = UIImagePickerController()
        picker.delegate = self
        
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
    }
    
    @IBAction func onRecognTapped(sender: RecognButton) {
        sender.startAnimation()
        if let image = photoImage {
            NNManager.shared().predictImage(image, callback: { description in
                print("image: \(description)")
                sender.stopAnimation()
            })
        }
        
    }
    
    @IBAction func onSelectFromGallery(sender: UIButton) {
        
        presentViewController(picker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            paintView.setPhoto(pickedImage)
            self.photoImage = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}