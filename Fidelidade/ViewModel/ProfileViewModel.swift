//  FrameworkTest
//  Created by Juninho on 26/11/21.

import UIKit


class ProfileViewModel {
    
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

