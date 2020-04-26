//
//  PhotosViewController.swift
//  photorama
//
//  Created by Joshua Vandermost on 2020-03-23.
//  Copyright © 2020 Joshua Vandermost. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    //@IBOutlet var uiView: UIView!
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    var photoArray = [Photo]()
    var increment = 1
    
    
    @IBAction func getNextImage(_ sender: UITapGestureRecognizer) {
        increment+=1
        self.updateImageView(for: photoArray[increment])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchAllImages()
        //if()
        store.fetchInterestingPhotos{
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                //self.photoArray = photos
                print("successfully saved all \(photos.count) photos")
                self.fetchAllImages()
                case let .failure(error):
                print("Error fetching interesting photos from database: \(error)")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func fetchAllImages(){
        store.fetchAllPhotos{
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photosArray):
                print("successfully fetched all \(photosArray.count) photos")
                self.photoArray = photosArray
                if let startingPhoto = photosArray.first{
                    self.updateImageView(for: startingPhoto)
                }
            case let .failure(error):
                print("Error fetching images from database: \(error)")
            }
    }
    }
    
    func updateImageView(for photo: Photo){
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
    
    private func updateDatasource(){
        store.fetchAllPhotos{(PhotoResult) in
            switch PhotoResult{
            case let .success(photos):
                self.photoArray = photos
            case let .failure:
                self.photoArray.removeAll()
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
