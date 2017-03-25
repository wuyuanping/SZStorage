//
//  SZGoodsOutputController.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsOutputController.h"
#import "YPSearchBar.h"
#import "SZOutputCell.h"
#import "SZSelectGoodsController.h"
#import "SZOrderController.h"
#import "SZSelectController.h"
#import "SZCoverView.h"
#import "SZSortKindButton.h"

@interface SZGoodsOutputController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *sortKinds;
@property (weak, nonatomic) IBOutlet UITableView *goodsTableView;
@property (nonatomic, strong) YPSearchBar *searchBar;
@property (nonatomic,strong) SZOrderController *OrderTableController;//排序
@property (nonatomic,strong) SZSelectController *SelectTableController;//筛选
@property (weak, nonatomic) IBOutlet SZSortKindButton *orderBtn; //排序按钮
@property (weak, nonatomic) IBOutlet SZSortKindButton *selectBtn; //筛选按钮
@property (nonatomic,assign) BOOL orderIsOpen;
@property (nonatomic,assign) BOOL selectIsOpen;
//@property (nonatomic,assign) BOOL isCreateCover;
@property (nonatomic,strong) SZCoverView *coverView;
@property (nonatomic,strong) SZCoverView *OrderCover;
@property (nonatomic,strong) SZCoverView *SelectCover;

@property (weak, nonatomic) IBOutlet UIView *showNoneView;

@end

@implementation SZGoodsOutputController

- (SZOrderController *)OrderTableController
{
    if (!_OrderTableController) {
        _OrderTableController = [[SZOrderController alloc] init];
        _OrderTableController.tableView.contentSize = CGSizeMake(SCREEN_W, 176);
        _OrderTableController.view.frame = CGRectMake(0, 98, SCREEN_W, 176);
        [self.view addSubview:_OrderTableController.view];
    }
    return _OrderTableController;
}

- (SZSelectController *)SelectTableController
{
    if (!_SelectTableController) {
        _SelectTableController = [[SZSelectController alloc] init];
        _SelectTableController.tableView.contentSize = CGSizeMake(SCREEN_W, 176);
        _SelectTableController.view.frame = CGRectMake(0, 98, SCREEN_W, 176);
        [self.view addSubview:_SelectTableController.view];
    }
    return _SelectTableController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp
{
    _showNoneView.hidden = YES;
    self.navigationItem.title = @"商品出库";
    self.view.backgroundColor = SZColor(240, 240, 240);
    _sortKinds.backgroundColor = SZColor(255, 255, 255);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _goodsTableView.delegate = self;
    _goodsTableView.dataSource = self;
    [self setNavigationBarBackgroundImage:IMAGE_NAMED(@"icon_导航条") tintColor:SZColor(46, 144, 255) textColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
    
    [self setBackItem];
    //监听通知
    [self registerForNotifications];
    
    //添加搜索框
    self.searchBar.frame = CGRectMake(0, 0, kScreenBounds.size.width, 44);
    [_searchView addSubview:_searchBar];
}

- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedOrder:) name:@"changOrder" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignTextFiled) name:@"removeCover" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeSelectTableView) name:@"selected" object:nil];
}

- (void)unregisterFromNotifications
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:@"changOrder" object:nil];
    [nc removeObserver:self name:@"removeCover" object:nil];
    [nc removeObserver:self name:@"selected" object:nil];
}

- (void)changedOrder:(NSNotification *)note
{
    _orderBtn.titleLabel.text = note.userInfo[@"order"];
    [self orderBtnClick];
}

- (void)closeSelectTableView
{
    [self selectBtnClick];
}

- (void)resignTextFiled
{
    [_searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    [_coverView removeFromSuperview];
}

#pragma mark - 搜索框 getter
- (YPSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[YPSearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.cursorColor = SZColor(45, 119, 253);  //设置光标颜色
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.placeholder = @"输入商品名称首字母搜索";
        _searchBar.textFieldBackgroundColor = SZColor(230, 230, 230);
        _searchBar.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
        _searchBar.delegate = self;
        [_searchBar textField].enablesReturnKeyAutomatically = YES; //无文字输入就不可以点击搜索
    }
    return _searchBar;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZOutputCell *cell = [SZOutputCell cellWithTableView:tableView];
    // TODO
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZSelectGoodsController *selGoodsVC = [[SZSelectGoodsController alloc] init];
    [self.navigationController pushViewController:selGoodsVC animated:YES];
}

#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder]; //searchBar失去焦点
    if(_searchBar.text.length){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"搜索" message:_searchBar.text preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirmAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
    //创建遮盖
    SZCoverView *coverView = [[SZCoverView alloc] init];
    [coverView showCoverWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) PositionToView:nil completion:nil];
    _coverView = coverView;
    if (_searchBar.searchBarTextField.text.length) {
        return;
    }
    //添加取消按钮
    YPSearchBar *sear = (YPSearchBar *)searchBar;
    sear.cancleButton.backgroundColor = [UIColor clearColor];
    [sear.cancleButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [sear.cancleButton setTitleColor:SZColor(45, 119, 253) forState:UIControlStateNormal];
    sear.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    //TODO :实时响应搜索结果排序
    NSLog(@"searchText:%@",searchText);
    if (searchText.length) {
        searchBar.showsCancelButton = NO;
    }else{
        YPSearchBar *sear = (YPSearchBar *)searchBar;
        sear.cancleButton.backgroundColor = [UIColor clearColor];
        [sear.cancleButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [sear.cancleButton setTitleColor:SZColor(45, 119, 253) forState:UIControlStateNormal];
        searchBar.showsCancelButton = YES;
    }
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
    if (_coverView) {
        [_coverView removeFromSuperview];
    }
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
}

- (BOOL)searchBar:(UISearchBar *)searchBar
shouldChangeTextInRange:(NSRange)range
  replacementText:(NSString *)text
{
    NSLog(@"%s",__func__);
    //取消Cancel按钮
    searchBar.showsCancelButton = NO;
    return YES; //返回NO表示不可以输入搜索文字，默认为YES
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s",__func__);
}

- (void)searchBar:(UISearchBar *)searchBar
selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
//    [_coverView removeFromSuperview];
//    [self.view endEditing:YES];
//    self.OrderTableController.view.height = 0;
//    self.SelectTableController.view.height = 0;
}

//点击排序
- (IBAction)orderBtnClick
{
    if (self.orderIsOpen) {//默认所有属性初始化都为0，即假
        self.OrderTableController.view.height = 0;
//        [_OrderCover removeFromSuperview];  // 不好使？？？？待解决
    }else{
        //创建遮盖
//        SZCoverView *orderCover = [[SZCoverView alloc] init];
//        _OrderCover = orderCover;
//        [orderCover showCoverWithFrame:CGRectMake(0, 339, SCREEN_W, SCREEN_H) PositionToView:nil completion:nil];
            self.OrderTableController.view.height = 176;
    }
    self.orderIsOpen = !self.orderIsOpen;
}

//点击筛选
- (IBAction)selectBtnClick
{
    if (self.selectIsOpen) {
        self.SelectTableController.view.height = 0;
//        [_SelectCover removeFromSuperview];  // 不好使？？？？待解决
    }else{
//        SZCoverView *selectCover = [[SZCoverView alloc] init];
//        _SelectCover = selectCover;
//        [selectCover showCoverWithFrame:CGRectMake(0, 339, SCREEN_W, SCREEN_H) PositionToView:nil completion:nil];
        self.SelectTableController.view.height = 176;
    }
    self.selectIsOpen = !self.selectIsOpen;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (_OrderTableController) {
        _OrderTableController.view.height = 0;
    }
    if (_SelectTableController) {
        _SelectTableController.view.height = 0;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_OrderTableController) {
        _OrderTableController.view.height = 0;
    }
    if (_SelectTableController) {
        _SelectTableController.view.height = 0;
    }
}
- (void)dealloc
{
    [self unregisterFromNotifications];
}


@end
