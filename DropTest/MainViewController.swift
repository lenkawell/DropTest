import UIKit

class MainViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        let viewController = PopoverViewController()
        viewController.view.backgroundColor = UIColor.lightGray
        let navController = UINavigationController(rootViewController: viewController)

        navController.modalPresentationStyle = .popover // dropInteraction delegate invoked with .formSheet
        
        if let popoverController = navController.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(origin: CGPoint(x: view.bounds.midX, y: view.bounds.midY), size: CGSize(width: 1, height: 1))
         }
        present(navController, animated: true, completion: nil)
    }
}

class PopoverViewController: UIViewController, UIDropInteractionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dropInteraction = UIDropInteraction(delegate: self)
        view.addInteraction(dropInteraction)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        NSLog("dropDelegate sessionDidEnter")
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        NSLog("dropDelegate drop canHandle")
        return true
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        NSLog("dropDelegate drop canHandle")
        return UIDropProposal(operation: .copy)
    }
}
