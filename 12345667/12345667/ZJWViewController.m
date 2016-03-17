//
//  ZYTestViewController.m
//  TestZoomScrollerView
//
//  Created by lyb on 15/11/27.
//  Copyright (c) 2015年 QQ:563180854. All rights reserved.
//
/*
 一、UIScrollerView的放大和缩小功能实现：
 1、用属性设置UIScrollerView的最大缩放比例和最小缩放比例
 2、用协议方法设置放在UIScrollerView中的哪个view要实现缩放功能(必须得是UIScrollerView中的view)
 完成以上两件事情即可实现UIScrollerView的缩放
 二、UIScrollerView的缩放原理
 当UIScrollerView的zoomScale改变的时候，系统所做的就是缩放UIScrollerView的contentSize的大小，并且让之前设置的这个view的frame属性的size和contentSize相同
 三、处理缩放的几个委托方法调用逻辑
 1、- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
 此方法当两个手指放在屏幕上的时候会调用两次，缩放的第一下会调用一次，所以整个缩放的过程会调用三次，参数指的就是设置委托的scrollView
 2、- (void)scrollViewDidZoom:(UIScrollView *)scrollView
 此方法只要scrollView进行缩放就会调用，参数指的就是设置委托的scrollView
 3、- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
 此方法当每次缩放停止的时候调用一次，第一个参数指的就是设置委托的scrollView，第二个参数指的就是scrollView中进行缩放的那个view(等同于代码中的_imageView)，第三个参数指的就是当前缩放的这个scrollView的zoomScal属性(等同于代码中scrollView.zoomScale)
 4、注意：当我们用手指去缩放scrollView的时候停止缩放会调用方法3，但如果我们直接设置了scrollView的zoomScale的时候就不会去调用方法3了;但是无论用手指还是直接通过代码设置zoomScale，都会调用方法1，用手指的话方法1会调用很多次，用代码设置的时候方法1只调用一次
 四、代码解释
 按理来说我们是无需实现方法3的，但是如果我们想在缩小的过程结束以后把view放在屏幕中间的话需要实现方法3，在里面完成功能；如果我们需要在缩放的过程中就想让view放在正中央的话，也可以将代码写在方法2中看需求而定
 
 */
#import "ZYTestViewController.h"
#import "MyScrollerView.h"

@interface ZYTestViewController (){
    MyScrollerView *_sc;
    UIImageView *_imgView;
}

@end

@implementation ZYTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    _sc=[[MyScrollerView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _sc.delegate=self;
    _imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    _imgView.image=[UIImage imageNamed:@"0.jpg"];
    [_sc addSubview:_imgView];
    _sc.contentSize=CGSizeMake(640, 0);
    //最小缩放比例
    _sc.minimumZoomScale=.2;
    //最大缩放比例
    _sc.maximumZoomScale=2;
    [self.view addSubview:_sc];
    
}
//设置放在scrollView中的哪个view能够缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    NSLog(@"%s",__func__);
    return _imgView;
}
//缩放完成的时候调用这个方法,缩放的时候其实改变的是scrollView的ContentSize，系统会让这个view的宽和高跟ContentSize的大小相同
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    if(_sc.zoomScale<=1.0){
        view.center=CGPointMake(160, 240);
    }else{
        view.center=CGPointMake(scrollView.contentSize.width/2, scrollView.contentSize.height/2);
    }
    
}
/*
 //touch事件是UIResponder中的方法,父类中的方法做了一件事情，将touch事件向响应者链中下一个响应者传递点击事件，子类重写了这个方法就不会将事件传递下去
 -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 //获取touch对象
 UITouch  *touch=[touches anyObject];
 if(touch.tapCount==2){
 NSLog(@"连点2次");
 }
 NSLog(@"点击");
 }
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
