////
////  WeatherApp
////
////  // Alok yadav on 2023-04-30.
////  Copyright © 2023 Alok yadav. All rights reserved.
////
import UIKit
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIStoryboard {
    
    func instantiateViewController<T:UIViewController>(type: T.Type) -> T? {
        debugPrint(type)
        var fullName: String = NSStringFromClass(T.self)
        if let range = fullName.range(of:".", options:.backwards, range:nil, locale: nil){
            fullName =  String(fullName[range.upperBound])
        }
        return self.instantiateViewController(withIdentifier:fullName) as? T
    }
    
    class func controller<T: UIViewController>(storyboard: StoryboardEnum) -> T {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: T.className) as! T
    }
    
    class func initial<T: UIViewController>(storyboard: StoryboardEnum) -> T {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateInitialViewController() as! T
    }
    
    enum StoryboardEnum: String {
        case main = "Main"
    }
}


extension NSObject {
  class var className: String {
    return String(describing: self.self)
  }
}
public enum RoundingPrecision {
    case ones
    case tenths
    case hundredths
    case thousands
}

extension Double {
    // Round to the specific decimal place
    func customRound(_ rule: FloatingPointRoundingRule, precision: RoundingPrecision = .ones) -> Double {
        switch precision {
        case .ones: return (self * Double(1)).rounded(rule) / 1
        case .tenths: return (self * Double(10)).rounded(rule) / 10
        case .hundredths: return (self * Double(100)).rounded(rule) / 100
        case .thousands: return (self * Double(1000)).rounded(rule) / 1000
        }
    }
   
}


//MARK: - TableView Helper
extension UITableView{
    func registerCell(_ cellIdentifier: String){
        self.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

//MARK : - REUSEABLE COLLECTION CELL
open class ReusableCollectionViewCell: UICollectionViewCell {
    
    /// Reuse Identifier String
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    /// Registers the Nib with the provided table
    public static func registerWithCollectionView(_ collectionView: UICollectionView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    
}

//MARK: - TableView Helper
extension UICollectionView{
    func registerCell(_ cellIdentifier: String){
        self.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    func reloadData(completion: @escaping ()->()) {
            UIView.animate(withDuration: 0, animations: { self.reloadData() })
            { _ in completion() }
        }
}
