# HZSigmentView
横向、可以移动的sigmentView，使用简单
### 看看效果
![这里写图片描述](http://img.blog.csdn.net/20160526200722125)

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
    self.sigment = [[HZSigmentView alloc] initWithOrgin:CGPointMake(0, 64) andHeight:44];
    self.sigment.delegate = self;
    self.sigment.titleArry = @[@"核桃",@"苹果",@"橘子",@"橙子",@"人民",@"打印机",@"电脑"];
    
    // 设置标题选中时的颜色
    //self.sigment.titleSelectColor = DDMColor(155, 0, 10);
    // 设置标题未选中的颜色
    //self.sigment.titleNomalColor = [UIColor redColor];
    // 默认选中第几项
    //self.sigment.defaultIndex = 2;
    // 设置标题字体大小
    //self.sigment.titleFont = [UIFont systemFontOfSize:9];

    
    [self.view addSubview:self.sigment];
```
### 代理函数 HZSigmentViewDelegate
  设置代理
  ```objc
  self.sigment.delegate = self;
  ```
  代理函数
  ```objc
  /**
 *  点击横向点击事件
 *
 *  @param sengment sengment对象
 *  @param index    点击的索引
 */
-(void)segment:(HZSigmentView *)sengment didSelectColumnIndex:(NSInteger)index;
  ```

### 设置titleArrys
  这里重写titleArrys的SET方法。在改方法里写的横向布局展示。

### 设置选中颜色
```objc
// 设置标题选中时的颜色
//self.sigment.titleSelectColor = DDMColor(155, 0, 10);
```
### 设置未选中的颜色
```objc
// 设置标题未选中的颜色
//  self.sigment.titleNomalColor = [UIColor redColor];
```
### 设置默认选中的索引
```objc
// 默认选中第几项
//self.sigment.defaultIndex = 2;
```
### 设置字体大小
```objc
// 设置标题字体大小
//  self.sigment.titleFont = [UIFont systemFontOfSize:9];
```


关注洲洲哥的微信公众号，提高技术就靠他了


![这里写图片描述](http://img.blog.csdn.net/20160520152250054)
 
 
 


