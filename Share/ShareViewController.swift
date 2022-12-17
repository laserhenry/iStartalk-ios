//
//  ShareViewController.swift
//  Share
//
//  Created by busylei on 2022/12/12.
//  Copyright © 2022 QIM. All rights reserved.
//

import UIKit
import UniformTypeIdentifiers
import Social
import AVFoundation

class ShareViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    static let IMAGE_IDENTIFIER = "public.image"
    static let MOVIE_IDENTIFIER = "public.movie"
    static let FILE_IDENTIFIER = "public.content"
    
    static let COLLECTION_CELL_IDENTIFIER = "cell"
    
    var toolbar: UIView!
    var items: [ShareItem] = []
    var collectionView: UICollectionView!

    override func loadView() {
        view = UIView()
        if #available(iOSApplicationExtension 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        addToolbar()
        
        

        let inputItem = self.extensionContext!.inputItems[0] as! NSExtensionItem
        let attachments = inputItem.attachments!
        if attachments.count == 1{
            let attachment = attachments[0]
            loadItem(attachment) { item in
                DispatchQueue.main.async {
                    self.addSingleItemView(item)
                }
            }
        }else{
           addMultiItemsView()
            for attachment in attachments {
                loadItem(attachment) { item in
                    DispatchQueue.main.async { [self] in
                        items.append(item)
                        collectionView.reloadData()
                    }
                }
            }
        }
    }

    func addToolbar(){
        toolbar = UIView()
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
        let cancelButton = makeButton(title: "Cancel", selector: #selector(cancel))
        toolbar.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor, constant: 15),
            cancelButton.centerYAnchor.constraint(equalTo: toolbar.centerYAnchor)
        ]);

        let sendButton = makeButton(title: "Send", selector: #selector(send))
        toolbar.addSubview(sendButton)
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: toolbar.trailingAnchor, constant: -15),
            sendButton.centerYAnchor.constraint(equalTo: toolbar.centerYAnchor)
        ]);

        let iconImage = UIImage(named: "ContainerIcon")
        let iconView = UIImageView(image: iconImage)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.layer.cornerRadius = 5
        iconView.layer.masksToBounds = true
        toolbar.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            iconView.centerXAnchor.constraint(equalTo: toolbar.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: toolbar.centerYAnchor)
        ]);
        
        let divider = UIView()
        if #available(iOSApplicationExtension 13.0, *) {
            divider.backgroundColor = .separator
        } else {
            divider.backgroundColor = .gray
        }
        divider.translatesAutoresizingMaskIntoConstraints = false
        toolbar.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: toolbar.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor),
        ]);
    }
    
    func addSingleItemView(_ item: ShareItem){
        let itemView = SingleShareItemView()
        setItemView(view: itemView, item: item)
        itemView.setup()
        view.addSubview(itemView)
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        itemView.topAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: 20).isActive = true
        if item.type == .image || item.type == .movie{
            let ratio = itemView.iamgeAspectRatio
            let maxHeight = itemView.imageMaxHeight
            NSLayoutConstraint.activate([
                itemView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                itemView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -30),
                itemView.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight),
                itemView.heightAnchor.constraint(equalTo: itemView.widthAnchor, multiplier: ratio),
            ])
        }else{
            let height = itemView.fileViewHeight
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15),
                itemView.heightAnchor.constraint(equalToConstant: height)
            ])
        }
    }
    
    func addMultiItemsView(){
        let collectionLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.COLLECTION_CELL_IDENTIFIER)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 5
        collectionView.clipsToBounds = true
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            collectionView.topAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: 15),
            collectionView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        var spacing: CGFloat = 10
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            spacing = layout.minimumInteritemSpacing
        }
        let size = (collectionView.bounds.width - 2 * spacing) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.COLLECTION_CELL_IDENTIFIER, for: indexPath)
        let item = items[indexPath.item]
        let contentView = cell.contentView
        
        let itemView = MultiShareItemView()
        setItemView(view: itemView, item: item)
        itemView.setup()
        contentView.addSubview(itemView)
        itemView.frame = contentView.bounds
        return cell
    }
    
    func loadItem(_ item: NSItemProvider, completionHandler: @escaping (_ item: ShareItem) -> Void){
        item.loadItem(forTypeIdentifier: Self.FILE_IDENTIFIER) { object, error in
            if let url = object as? URL{
                let shareItem: ShareItem
                if item.hasItemConformingToTypeIdentifier(Self.IMAGE_IDENTIFIER){
                    let image = UIImage(contentsOfFile: url.path)
                    shareItem = ShareItem(type: .image, image: image)
                }else if item.hasItemConformingToTypeIdentifier(Self.MOVIE_IDENTIFIER){
                    let asset = AVURLAsset(url: url)
                    shareItem = ShareItem(type: .movie, movie: asset)
                }else{
                    let name = url.lastPathComponent
                    let data = try! Data(contentsOf: url)
                    let file = ShareFile(name: name, data: data)
                    shareItem = ShareItem(type: .file, file: file)
                }
             
                completionHandler(shareItem)
            }
        }
    }

    func setItemView(view: BaseShareItemView, item: ShareItem){
        view.type = item.type
        view.image = item.image
        view.movie = item.movie
        view.file = item.file
    }
    
    @objc func cancel(){

    }

    @objc func send(){

    }

    func makeButton(title: String, selector: Selector) -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

}

enum ShareType{
    case image
    case movie
    case file
}


struct ShareFile{
    var name: String
    var data: Data
}

struct ShareItem{
    var type: ShareType
    var image: UIImage?
    var movie: AVAsset?
    var file: ShareFile?
}
