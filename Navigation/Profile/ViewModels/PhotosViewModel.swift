import UIKit

protocol PhotosViewOutput: class {
    var photosModel: PhotosModel { get }
    func getPhotos() -> [UIImage]
    func getPhotosCount() -> Int
}

class PhotosViewModel: PhotosViewOutput {
    var photosModel: PhotosModel {
        return PhotosModel()
    }
    
    func getPhotos() -> [UIImage] {
        return photosModel.images
    }
    
    func getPhotosCount() -> Int {
        return photosModel.images.count
    }
}

