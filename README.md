# MOPhotoPreviewer

![Swift3](https://img.shields.io/badge/Swift-3.0-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://coding.net/u/four4/p/Diary/git/blob/master/LICENSE)

图片点击放大、缩放和保存，类似于微信点击头像效果。

##### 效果图：

![photoPreviewer](http://7xsjfr.com1.z0.glb.clouddn.com/photoPreviewer.gif)

##### 用法：

导入 MOPhotoPreviewer 到项目中

```
// 在图片的点击动作里添加以下代码, 其中 imageView 为原图的 UIImageView

let photoView = MOPhotoPreviewer()
photoView.preview(fromImageView: imageView, container: self.view)

```

*注： 这里只实现了单张图片的点击浏览
