import UIKit

protocol PhotosViewOutput: class {
    var photosModel: PhotosModel { get }
    func getPhotos(section: Int) -> [UIImage]
    func getPhotosCount(section: Int) -> Int
    func getSectionsCount() -> Int
}

class PhotosViewModel: PhotosViewOutput {
    var photosModel: PhotosModel {
        return PhotosModel()
    }
    
    func getPhotos(section: Int) -> [UIImage] {
        return photosModel.images[section].photos
    }
    
    func getPhotosCount(section: Int) -> Int {
        return photosModel.images[section].photos.count
    }
    
    func getSectionsCount() -> Int {
        return photosModel.images.count
    }
}

