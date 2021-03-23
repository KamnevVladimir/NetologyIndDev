import UIKit

protocol PhotosViewOutput: class {
    var photosModel: PhotosModel { get set }
    func getPhotos() -> [UIImage]
    func getPhotosCount() -> Int
}


