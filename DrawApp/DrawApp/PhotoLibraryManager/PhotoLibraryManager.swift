import UIKit
import PhotosUI

class PhotoLibraryManager {
    
    static let shared = PhotoLibraryManager()
    private init() {}
    
    func saveImage(canvasView: CanvasView) {
        
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image ?? UIImage())
            } completionHandler: { success, error in
                success ? print("image was saved") : print("image doest saved \(error?.localizedDescription ?? "")")
            }

        }
    }
}

