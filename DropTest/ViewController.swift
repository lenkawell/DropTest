//
//  ViewController.swift
//  DropTest
//
//  Created by Len Kawell on 9/18/23.
//

import UIKit

class CustomizeAnimationsActionCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var iconImageView: UIImageView!
}

class CustomizeAnimationsStepCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
    @IBOutlet var infoLabel: UILabel!
}


class CustomizeAnimationsHeader: UICollectionReusableView {
    @IBOutlet var label: UILabel!
}


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UIDropInteractionDelegate {

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
               
        view.interactions = []
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        
        let dropInteraction = UIDropInteraction(delegate: self)
        view.addInteraction(dropInteraction)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("viewDidAppear")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 6 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionCell", for: indexPath) as! CustomizeAnimationsActionCell
            cell.label.text = "Action \(indexPath.item)"
            cell.iconImageView.image = UIImage(systemName: "tv")
            return cell

        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepCell", for: indexPath) as! CustomizeAnimationsStepCell
            cell.label.text = "Step \(indexPath.item)"
            cell.infoLabel.text = "Info"
            return cell

        default:
            return UICollectionViewCell()
        }

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
    
    // Drag Delegate.
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        NSLog("drag itemsForBeginning")
        
        let itemProvider = NSItemProvider(object: "Test" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = indexPath
        return [dragItem]
    }

    func collectionView(_ collectionView: UICollectionView, dragSessionAllowsMoveOperation session: UIDragSession) -> Bool {
        NSLog("dragSessionAllowsMove")
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        NSLog("dragPreviewParametersForItemAt \(indexPath)")
        return nil
    }
    
     func collectionView(_ collectionView: UICollectionView, dragSessionWillBegin session: UIDragSession) {
        NSLog("dragSessionWillBegin")
    }
    
    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        NSLog("dragSessionDidEnd")
    }

    func collectionView(_ collectionView: UICollectionView, dragSessionIsRestrictedToDraggingApplication session: UIDragSession) -> Bool {
        NSLog("dragSessionIsRestricted")
        return false
    }
    
    
    
    // Drop Delegate
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        NSLog("collectionView drop canHandle")
        return collectionView.hasActiveDrag
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnter session: UIDropSession) {
        NSLog("drop didEnter")
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {

//        NSLog("dropSessionDidUpdate")

        return UICollectionViewDropProposal(operation: destinationIndexPath?.section == 0 ? .forbidden : .copy)
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {

        NSLog("performDrop destination = \(String(describing: coordinator.destinationIndexPath))")
    }
}

