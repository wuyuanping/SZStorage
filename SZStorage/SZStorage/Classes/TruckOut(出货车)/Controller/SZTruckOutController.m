//
//  SZTruckOutController.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZTruckOutController.h"

@interface SZTruckOutController ()
@property (nonatomic ,weak) CALayer *fistLayer;
@property (strong, nonatomic)  NSMutableArray *imageArray;

@end

@implementation SZTruckOutController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"出货车";
    self.view.backgroundColor = [UIColor redColor];
    [self setNavigationBarBackgroundImage:IMAGE_NAMED(@"icon_导航条") tintColor:SZColor(46, 144, 255) textColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
    
    //设置背景
    self.view.layer.contents = (id)[UIImage imageNamed:@"bg"].CGImage;
    
    CALayer *fistLayer = [CALayer layer];
    fistLayer.frame = CGRectMake(100, 288, 89, 40);
    self.fistLayer = fistLayer;
    [self.view.layer addSublayer:fistLayer];
    
    //加载图片
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"fish%d",i]];
        [imageArray addObject:image];
    }
    self.imageArray = imageArray;
    
    //添加定时器（鱼不停地换图片身体摆动才感觉是活的）
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    [self fishPlay];
}
static int _imageIndex = 0;
- (void)update {
    
    //从数组当中取出图片
    UIImage *image = self.imageArray[_imageIndex];
    self.fistLayer.contents = (id)image.CGImage;//图片赋值给layer
    _imageIndex++;
    if (_imageIndex > 9) {
        _imageIndex = 0;
    }
}

- (void)fishPlay{
    //1创建关键帧动画(鱼改变位置属性去移动)
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 288)];
    [path addLineToPoint:CGPointMake(100, 50)];
    [path addLineToPoint:CGPointMake(300, 50)];
    [path addLineToPoint:CGPointMake(300, 400)];
    [path addQuadCurveToPoint:CGPointMake(100, 288) controlPoint:CGPointMake(180, 600)];
    
    anim.path = path.CGPath;  //Path属性专门用来设置路径动画的
    
    anim.repeatCount = HUGE;
    anim.duration = 5.0;
    anim.rotationMode = @"autoReverse";
    anim.calculationMode = @"cubic";
    
    [self.fistLayer addAnimation:anim forKey:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self fishPlay];
}

@end
