# HZSingmentScrollView
横向、可以移动的HZSingmentScrollView，使用简单
### 看看效果
![这里写图片描述](http://img.blog.csdn.net/20160603172856243)

### 使用时一定要注意些上这样一句，或者在你的工程里添加上这样一句话
```objc
  ****两句设置任意选择其中一个
// 原点从（0，64）开始
//    self.navigationController.navigationBar.translucent = NO;
// 原点从（0，0）开始
self.automaticallyAdjustsScrollViewInsets = NO;
```


### HZSigmentView的创建
```objc
    self.fisrstVC = [[firstViewController alloc] init];
    self.secVC = [[secViewController alloc] init];
    self.thirdVC = [[ThirdViewController alloc] init];
    self.fourVC = [[FourViewController alloc] init];
    
    self.SingmentScrollView = [[HZSigmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
    // 设置标题
    self.SingmentScrollView.titleScrollArrys = @[@"核桃",@"苹果",@"香蕉",@"荔枝"].mutableCopy;
    // 设置控制器
    self.SingmentScrollView.titleControllerArrys = @[self.fisrstVC,self.secVC,self.thirdVC,self.fourVC].mutableCopy;
    [self.view addSubview:self.SingmentScrollView];
```
### 代理函数 HZSigmentViewDelegate
  
  ```objc
  改功能沿用了HZSingmentView的功能，在他的基础添加功能。
  每个对应item都有一个对应控制器，当触发点击事件时，就会有控制器显示出来以动画形式展现。
  ```
  


关注洲洲哥的微信公众号，提高技术就靠他了


![这里写图片描述](http://img.blog.csdn.net/20160520152250054)
 
 
 


