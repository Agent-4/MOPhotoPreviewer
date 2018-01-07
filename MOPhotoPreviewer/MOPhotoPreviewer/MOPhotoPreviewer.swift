//
//  MoPhotoPreviewer.swift
//  Mo
//
//  Created by moxiaohao on 2017/3/24.
//  Copyright © 2017年 moxiaohao. All rights reserved.
//

import UIKit
import Photos

class MOPhotoPreviewer: UIView, UIScrollViewDelegate {
    
    var blurBackground: UIVisualEffectView?  // 模糊背景
    var scrollView: UIScrollView?            // UIScrollView
    var containerView: UIView?               // 存放 imageView 容器
    var imageView: UIImageView?              // 显示的图片
    var fromTheImageView: UIImageView?       // 传递过来的小图片
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        frame = UIScreen.main.bounds
        backgroundColor = UIColor.clear
        // 单击
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(_:)))
        addGestureRecognizer(singleTap)
        // 双击
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        singleTap.require(toFail: doubleTap)
        addGestureRecognizer(doubleTap)
        // 长按
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        addGestureRecognizer(longPress)
        
        // 设置模糊背景
        blurBackground = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blurBackground?.frame = frame
        addSubview(blurBackground!)
        
        // 设置 UIScrollView 相关属性
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView?.delegate = self
        scrollView?.bouncesZoom = true
        scrollView?.maximumZoomScale = 3.0
        scrollView?.isMultipleTouchEnabled = true
        scrollView?.alwaysBounceVertical = false
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        addSubview(scrollView!)
        
        // containerView 容器视图
        containerView = UIView()
        scrollView?.addSubview(containerView!)
        
        // imageView 图片视图
        imageView = UIImageView()
        imageView?.clipsToBounds = true
        imageView?.backgroundColor = UIColor(white: CGFloat(1.0), alpha: CGFloat(0.5))
        containerView?.addSubview(imageView!)
    }
    
    func preview(fromImageView: UIImageView, container: UIView) {
        fromTheImageView = fromImageView
        fromTheImageView?.isHidden = true
        container.addSubview(self) // 将 PhotoPreviewer 添加到 container 上
        
        containerView?.mo_origin = CGPoint.zero
        containerView?.mo_width = mo_width // containerView 的宽度是屏幕的宽度
        
        let image: UIImage? = fromTheImageView?.image
        
        // 计算 containerView 的高度
        if (image?.size.height)! / (image?.size.height)! > self.mo_height / mo_width {
            containerView?.mo_height = floor((image?.size.height)! / ((image?.size.width)! / mo_width))
        }else {
            var height: CGFloat? = (image?.size.height)! / (image?.size.width)! * mo_width
            if (height! < CGFloat(1) || (height?.isNaN)!) {
                height = self.mo_height
            }
            height = floor(height!)
            containerView?.mo_height = height!
            containerView?.mo_centerY = self.mo_height / 2
        }
        
        if (containerView?.mo_height)! > self.mo_height && (containerView?.mo_height)! - self.mo_height <= 1 {
            containerView?.mo_height = self.mo_height
        }
        
        scrollView?.contentSize = CGSize(width: CGFloat(mo_width), height: CGFloat(max((containerView?.mo_height)!, self.mo_height)))
        scrollView?.scrollRectToVisible(bounds, animated: false)
        
        if (containerView?.mo_height)! <= self.mo_height {
            scrollView?.alwaysBounceVertical = false
        }else {
            scrollView?.alwaysBounceVertical = true
        }
        
        let fromRect: CGRect = (self.fromTheImageView?.convert((self.fromTheImageView?.bounds)!, to: self.containerView))!
        imageView?.frame = fromRect
        imageView?.contentMode = .scaleAspectFill
        imageView?.image = image
        
        UIView.animate(withDuration: 0.18, delay: 0.0, options: [.beginFromCurrentState, .curveEaseInOut], animations: {() -> Void in
            self.imageView?.frame = (self.containerView?.bounds)!
            self.imageView?.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.18, delay: 0.0, options: [.beginFromCurrentState, .curveEaseInOut], animations: {() -> Void in
                self.imageView?.transform = CGAffineTransform(scaleX: 1.00, y: 1.00)
            }, completion: nil)
        })
    }
    
    // 返回
    func dismiss() {
        UIView.animate(withDuration: 0.18, delay: 0.0, options: .curveEaseInOut, animations: {() -> Void in
            let fromRect: CGRect = (self.fromTheImageView?.convert((self.fromTheImageView?.bounds)!, to: self.containerView))!
            self.imageView?.contentMode = (self.fromTheImageView?.contentMode)!
            self.imageView?.frame = fromRect
            self.blurBackground?.alpha = 0.01
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.10, delay: 0, options: .curveEaseInOut, animations: {() -> Void in
                self.fromTheImageView?.isHidden = false
                self.alpha = 0
            }, completion: {(_ finished: Bool) -> Void in
                self.removeFromSuperview()
            })
        })
    }
    
    // MARK: - <UIScrollViewDelegate>
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView!
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let subView: UIView? = containerView
        let offsetX: CGFloat = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0
        let offsetY: CGFloat = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0
        subView?.center = CGPoint(x: CGFloat(scrollView.contentSize.width * 0.5 + offsetX), y: CGFloat(scrollView.contentSize.height * 0.5 + offsetY))
    }
    
    // MARK: - GestureRecognizer
    
    // 单击   ** dismiss **
    @objc func singleTap(_ recognizer: UITapGestureRecognizer) {
        dismiss()
    }
    
    // 双击   ** 放大 **
    @objc func doubleTap(_ recognizer: UITapGestureRecognizer) {
        if (scrollView?.zoomScale)! > CGFloat(1.0) {
            scrollView?.setZoomScale(1.0, animated: true)
        }else {
            let touchPoint: CGPoint = recognizer.location(in: imageView)
            let newZoomScale: CGFloat = scrollView!.maximumZoomScale
            let xSize: CGFloat = mo_width / newZoomScale
            let ySize: CGFloat = mo_height / newZoomScale
            scrollView?.zoom(to: CGRect(x: CGFloat(touchPoint.x - xSize / 2), y: CGFloat(touchPoint.y - ySize / 2), width: xSize, height: ySize), animated: true)
        }
    }
    
    // 长按   ** 保存图片到相册 **
    @objc func longPress(_ recognizer: UILongPressGestureRecognizer) {
        // 最好加入状态判断
        if recognizer.state == .began {
            let image = fromTheImageView?.image
            let alertController = UIAlertController(title: "保存图片", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "保存", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                PHPhotoLibrary.shared().performChanges({() -> Void in
                    //写入图片到相册
                    PHAssetChangeRequest.creationRequestForAsset(from: image!)
                }, completionHandler: {(succeeded, error) -> Void in
                    // 最好是异步操作，否则可能会阻塞主线程或引起奇怪的崩溃
                    DispatchQueue.main.async {
                        if succeeded {
                            // 保存成功的提示 ** 自己可以自定义加入 HUD 提示 **
                            print("保存成功！")
                        }else {
                            // 保存失败的提示 ** 自己可以自定义加入 HUD 提示 **
                            print("保存失败！")
                        }
                    }
                })
            }))
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            let vc: UIViewController? = currentViewController()
            vc?.present(alertController, animated: true, completion: nil)
        }
    }
    
}
