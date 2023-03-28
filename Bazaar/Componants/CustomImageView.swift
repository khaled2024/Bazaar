//
//  ImageView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit
class CustomImageView: UIImageView{
    
    var task: URLSessionDataTask!
    var imageCache = NSCache<AnyObject,AnyObject>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("coder dose not implemented")
    }
    convenience init(image: UIImage? = nil,
                     tintColor: UIColor? = nil,
                     bacgroundColor: UIColor? = nil,
                     contentMode: ContentMode,
                     maskToBound: Bool? = nil,
                     cornerRadius: CGFloat? = nil,
                     isUserInteractionEnabled:Bool? = nil) {
        self.init(frame: .zero)
        set(image: image, tintColor: tintColor, backgroundColor: bacgroundColor, contentMode: contentMode, maskedToBounds: maskToBound, cornerRadius: cornerRadius, isUserInteractionEnabled: isUserInteractionEnabled)
        
    }
    func config(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    // set the proparties to self
    func set(image: UIImage? = nil, tintColor: UIColor? = nil, backgroundColor: UIColor? = nil, contentMode: ContentMode, maskedToBounds: Bool? = nil ,cornerRadius: CGFloat? = nil, isUserInteractionEnabled: Bool? = nil){
        self.contentMode = contentMode
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        
        if let image = image{
            self.image = image
        }
        if let maskedToBounds = maskedToBounds{
            layer.masksToBounds = maskedToBounds
        }
        if let cornerRadius = cornerRadius{
            layer.cornerRadius = cornerRadius
        }
        if let isUserInteractionEnabled = isUserInteractionEnabled {
            self.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }
    // for download image with image cache...
    func downloadSetImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let task = task{
            task.cancel()
        }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject)as? UIImage{
            self.image = imageFromCache
            return
        }
         task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
             self.imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        task.resume()
    }
}
