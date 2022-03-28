import UIKit
import Foundation

class PlatformViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func switchToFlutterView(_ sender: Any) {
        dismiss(animated:false, completion:nil)
    }
    
}
