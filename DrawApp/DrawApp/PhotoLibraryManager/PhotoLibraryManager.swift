import PhotosUI
import UIKit

class PhotoLibraryManager {
    
    static let shared = PhotoLibraryManager()
    private init() {}
 
    
    func saveImage(canvasView: CanvasView, completion: @escaping (Bool, Error?) -> Void) {
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)

        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
//
        if image != nil {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: completion)
        }
    }
}

