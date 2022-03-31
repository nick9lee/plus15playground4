import UIKit
import MapKit

class UserLocationAnnotationView: MKAnnotationView {

    var arrowImageView: UIImageView!

    private var kvoContext: UInt8 = 13

    override public init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        arrowImageView = UIImageView(image: #imageLiteral(resourceName: "Black_Arrow_Up.svg"))
        addSubview(arrowImageView)
        setupObserver()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        arrowImageView = UIImageView(image: #imageLiteral(resourceName: "Black_Arrow_Up.svg"))
        addSubview(arrowImageView)
        setupObserver()
    }

    func setupObserver() {
        (annotation as? UserLocationAnnotation)?.addObserver(self, forKeyPath: "heading", options: [.initial, .new], context: &kvoContext)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &kvoContext {
            let userLocationAnnotation = annotation as! UserLocationAnnotation
            UIView.animate(withDuration: 0.2, animations: { [unowned self] in
                self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(userLocationAnnotation.heading / 180 * Double.pi))
            })
        }
    }

    deinit {
        (annotation as? UserLocationAnnotation)?.removeObserver(self, forKeyPath: "heading")
    }
}
