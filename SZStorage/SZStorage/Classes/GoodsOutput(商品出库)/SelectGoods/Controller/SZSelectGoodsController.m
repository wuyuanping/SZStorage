//
//  SZSelectGoodsController.m
//  SZStorage
//
//  Created by 吴园平 on 17/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSelectGoodsController.h"
#import "SZRedViewController.h"
#import "SZWhiteViewController.h"

@interface SZSelectGoodsController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *prePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;

@property (nonatomic,weak) UIScrollView *topScrollView;
@property (nonatomic,weak) UICollectionView *bottomCollectionView;
@property (nonatomic,weak) UIButton *selectedBtn;
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,weak) UIView *underLine;
@property (nonatomic,assign) BOOL isInitial;//tips，用于控制只添加一次顶部View按钮

@property (weak, nonatomic) IBOutlet UIView *bottomContentView;

@end

static NSString * const ID = @"cell";
@implementation SZSelectGoodsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self addAllChildViewController];
    
    //1.添加底部(正文)内容View
    [self setupBottomContainerView];
    
    //2.添加中间顶部标题View
    [self setupTopTitleView];
}

- (void)setup
{
    self.navigationItem.title = @"选择商品";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = SZColor(240, 240, 240);
}

- (void)addAllChildViewController
{
    //红色
    SZRedViewController *redVC = [[SZRedViewController alloc] init];
    redVC.title = @"红色";
    [self addChildViewController:redVC];
    
    //白色
    SZWhiteViewController *whiteVC = [[SZWhiteViewController alloc] init];
    whiteVC.title = @"白色";
    [self addChildViewController:whiteVC];
}

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
        [self setupAllTitleButton];
        _isInitial = YES;
    }
}

- (void)setupBottomContainerView
{
    //1.创建UICollectionView
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(SCREEN_W, _bottomContentView.yp_height - 45);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_W, _bottomContentView.yp_height - 45) collectionViewLayout:flow];
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.prefetchingEnabled = NO;//xcode8之后新增加属性，默认为YES，取消预加载达到优化性能作用.
    collectionView.scrollsToTop = NO;//取消不需要的scrollview，点击导航栏时只保留一个需要的滚动的!!!
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = YES;
    collectionView.bounces = NO;//取消弹簧效果
    collectionView.pagingEnabled = YES;
    
    //2.注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self.bottomContentView addSubview:collectionView];
    _bottomCollectionView = collectionView;
}

- (void)setupTopTitleView
{
    //创建UIScrollview
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 44)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.scrollsToTop = NO;//取消不需要的scrollview，只保留一个需要的
    [self.bottomContentView addSubview:scrollView];
    _topScrollView = scrollView;
}

- (void)setupAllTitleButton
{
    //确定按钮个数
    NSInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnW = SCREEN_W / count;
    CGFloat btnH = _topScrollView.yp_height;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        //按钮的标题为控制器的title
        UIViewController *vc = self.childViewControllers[i];//多态
        [btn setTitle:vc.title forState:UIControlStateNormal];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [_topScrollView addSubview:btn];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:SZColor(138, 138, 138) forState:UIControlStateNormal];
        [btn setTitleColor:SZColor(71, 147, 250) forState:UIControlStateSelected];
        //监听按钮点击
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btns addObject:btn]; //将来滑动时根据数组下标选中按钮
        if (i == 0) {
            //1.添加下划线
            UIView *underLine = [[UIView alloc] init];
            underLine.backgroundColor = SZColor(71, 147, 250);
            _underLine = underLine;
            //确定下划线位置(下划线中心点x等于按钮中心点X值，长度等于按钮中titleLabel控件的长度)
            [btn.titleLabel sizeToFit];
            underLine.yp_height = 2;
            underLine.yp_width = btn.titleLabel.yp_width;
            underLine.yp_centerX = btn.yp_centerX;
            underLine.yp_y = _topScrollView.yp_height - underLine.yp_height;
            [_topScrollView addSubview:underLine];
            
            //2.选中第一个按钮
            [self titleClick:btn];
        }
    }
}

- (void)titleClick:(UIButton *)button
{
    //1.选中三部曲
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
    
    //2.移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        _underLine.yp_centerX = button.yp_centerX;
    }];
    
    //3.移动collectionview内容
    NSInteger i = button.tag;
    CGFloat offset = i * SCREEN_W;
    _bottomCollectionView.contentOffset = CGPointMake(offset, 0);
    
    //4.重复点击主题界面按钮加载数据
    if (button == _selectedBtn) {
        
        //        YPBaseTableViewCell *baseVC = self.childViewControllers[i];
        // 刷新当前控制器的View
        //        [baseVC reload];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

// 每次只要有新的cell出现就会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 1.移除之前子控制器的View
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 2.切换子控制器View
    SZBaseViewController *vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, SCREEN_W, _bottomContentView.yp_height);
    [cell.contentView addSubview:vc.view];
    return cell;
}

#pragma mark - UICollectionViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手指滚动collectionView也可以选择按钮
    NSInteger page = scrollView.contentOffset.x / SCREEN_W;
    UIButton *btn = self.btns[page];
    [self titleClick:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
