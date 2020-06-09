//
//  PhotoManager.swift
//  dsb
//
//  Created by 江俊瑩 on 2020/5/18.
//  Copyright © 2020 江俊瑩. All rights reserved.
//

import UIKit

//xcode Catalina 模擬器要篩圖 要先放到模擬器的路徑才能直接丟到模擬器中 apple bug

public class PhotoManager: NSObject {
    
    private override init() {}
    public static let share = PhotoManager()
    
    /// 選取相簿結束事件
    public var didFinishPickingMediaWithInfo: ((UIImage)->())? = nil
    public var imagePicker: UIImagePickerController? = nil
    
}

public extension PhotoManager {
    
    func showAlbum(vc: UIViewController) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        vc.present(imagePicker, animated: true, completion: nil)
        self.imagePicker = imagePicker
    }
    
    //need Add info.plist:
    //Privacy - Camera Usage Description
    //Localized resources can be mixed Yes (相機本地化)
    
    func showCamera(vc: UIViewController) {
        
        let imagePicker = UIImagePickerController() //不支援qrcode監測
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.delegate = self

        vc.present(imagePicker, animated: true, completion: nil)
        self.imagePicker = imagePicker
    }
    
    // 測試用法
    @IBAction func action(_ sender: Any) {
        
//        PermissionsChecker.canUseCamera { bool in
//            bool ? PhotoManager.share.showCamera(vc: UIViewController()) : ()
//        }
    }
    
}

public extension PhotoManager: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            didFinishPickingMediaWithInfo?(image)
            
            imagePicker?.dismiss(animated: true, completion: nil)
        }
    }
    
}


