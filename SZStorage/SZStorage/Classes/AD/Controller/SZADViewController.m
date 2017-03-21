//
//  SZADViewController.m
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZADViewController.h"
#import "SZADItem.h"
#import "SZTabBarController.h"
#import "SZSaveTool.h"
#import "SZRegisterViewController.h"

#define iPhone6P (SCREEN_H == 736)
#define iPhone6 (SCREEN_H == 667)
#define iPhone5 (SCREEN_H == 568)
#define iPhone4 (SCREEN_H == 480)

@interface SZADViewController ()
//启动图片
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
//占位视图
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic,strong) SZADItem *ADItem;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,weak) NSTimer *timer;
@end

@implementation SZADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLaunchImage];
    [self loadADData];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

#pragma mark - 设置启动图片
- (void)setupLaunchImage
{    
    //根据屏幕去加载不同启动图片
    UIImage *image = nil;
    if (iPhone6P) {
        image = IMAGE_NAMED(@"LaunchImage-800-667h@2x.png");
    }else if (iPhone6){
        image = IMAGE_NAMED(@"LaunchImage-800-667h@2x.png");
    }else if (iPhone5){
        image = IMAGE_NAMED(@"LaunchImage-700-568h@2x.png");
    }else if (iPhone4){
        image = IMAGE_NAMED(@"LaunchImage@2x.png");
    }
    _launchImageView.image = image;
}

#pragma mark - 展示广告数据
- (void)loadADData{
    
    
    //    //1.创建请求会话管理者
    //    AFHTTPSessionManager *mgr = [AFHTTPSessionManager YP_manager];//可以容错了
    //
    //    //2.拼接参数(该框架中参数一般用字典存储)
    //    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //    parameters[@"code2"] = code2;
    //
    //    //3.发送请求
    //    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //        //1.获取字典广告
    //        NSDictionary *adDict = [responseObject[@"ad"] firstObject];//只有一个
    //
    //        //2.字典转模型
    //        YPADItem *adItem = [YPADItem mj_objectWithKeyValues:adDict];
    //        _ADItem = adItem;
    //
    //        //3.显示广告图片
    //        UIImageView *imageView = [[UIImageView alloc] init];
    //        imageView.userInteractionEnabled = YES;
    //        CGFloat h = 0;
    //        if (adItem.w > 0) { //注意：分母不为0
    //            h = YPScreenW / adItem.w * adItem.h;//tips
    //        }
    //        imageView.frame = CGRectMake(0, 0, YPScreenW, h);
    //        [imageView sd_setImageWithURL:[NSURL URLWithString:adItem.w_picurl]];
    //        [self.contentView addSubview:imageView];
    //
    //        //4.广告图片添加手势
    //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    //        [imageView addGestureRecognizer:tap];
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        NSLog(@"%@",error);
    //    }];
}

- (void)timerChange
{
    static NSUInteger i = 3;
    i --;
    [_btn setTitle:[NSString stringWithFormat:@"跳过(%zd)",i]forState:UIControlStateNormal];
    if (i == -1) {
        [self jump:nil];
    }
}

//进入主页面
- (IBAction)jump:(id)sender
{
    if ([SZSaveTool objectForKey:kSZIsLogined]) {
        SZTabBarController *tabBarVC = [[SZTabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    }else{
        SZRegisterViewController *registerVC = [[SZRegisterViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = registerVC;
    }
    [_timer invalidate];
    _timer = nil;
}

- (void)tap
{
    //跳转到广告链接
    NSURL *url = [NSURL URLWithString:_ADItem.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
