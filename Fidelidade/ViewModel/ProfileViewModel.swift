//  FrameworkTest
//  Created by Juninho on 26/11/21.

import UIKit
import Observable


class ProfileViewModel {
    
    let defaults = UserDefaults.standard
    
    @MutableObservable private var sLogoutIsFinished: Bool?
    var logoutIsFinished: Observable<Bool?>{
        return _sLogoutIsFinished
    }
    
    func handleLogout() {
        guard let _ = defaults.string(forKey: UserDefaultsKeys.userKey.rawValue), let _ = defaults.string(forKey: UserDefaultsKeys.userCpf.rawValue), let _ = defaults.string(forKey: UserDefaultsKeys.userId.rawValue), let _ = defaults.string(forKey: UserDefaultsKeys.userImageProfile.rawValue) else {
            sLogoutIsFinished = false
            return
        }
        
        defaults.removeObject(forKey: UserDefaultsKeys.userKey.rawValue)
        defaults.removeObject(forKey: UserDefaultsKeys.userCpf.rawValue)
        defaults.removeObject(forKey: UserDefaultsKeys.userId.rawValue)
        defaults.removeObject(forKey: UserDefaultsKeys.userImageProfile.rawValue)
        sLogoutIsFinished = true
    }
    
    func blurImageView(image: UIImageView) {
        //Borrão na imagem
        let inputImage = CIImage(cgImage: (image.image?.cgImage)!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: "inputImage")
        filter?.setValue(3, forKey: "inputRadius")
        let blurred = filter?.outputImage
        
        var newImageSize: CGRect = (blurred?.extent)!
        newImageSize.origin.x += (newImageSize.size.width - (image.image?.size.width)!) / 2
        newImageSize.origin.y += (newImageSize.size.height - (image.image?.size.height)!) / 2
        newImageSize.size = (image.image?.size)!

        let resultImage: CIImage = filter?.value(forKey: "outputImage") as! CIImage
        let context: CIContext = CIContext.init(options: nil)
        let cgimg: CGImage = context.createCGImage(resultImage, from: newImageSize)!
        let blurredImage: UIImage = UIImage.init(cgImage: cgimg)
        image.image = blurredImage
    }
}

