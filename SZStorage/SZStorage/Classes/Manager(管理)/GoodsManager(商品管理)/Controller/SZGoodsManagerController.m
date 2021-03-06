//
//  SZGoodsManagerController.m
//  SZStorage
//
//  Created by 吴园平 on 25/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsManagerController.h"
#import "YPSearchBar.h"
#import "SZCoverView.h"
#import "SZSelectController.h"
#import "SZOrderController.h"
#import "SZSortKindButton.h"
#import "SZGoodsManagerCell.h"
#import "SZGoodsDetailController.h"

@interface SZGoodsManagerController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (nonatomic,strong) YPSearchBar *searchBar;
@property (nonatomic,strong) SZCoverView *coverView;
@property (nonatomic,strong) SZOrderController *OrderTableController;//排序
@property (nonatomic,strong) SZSelectController *SelectTableController;//筛选

@property (nonatomic,assign) BOOL orderIsOpen;
@property (nonatomic,assign) BOOL selectIsOpen;

@property (weak, nonatomic) IBOutlet UIView *sortKind;
@property (weak, nonatomic) IBOutlet SZSortKindButton *orderBtn; //排序按钮
@property (weak, nonatomic) IBOutlet SZSortKindButton *selectBtn; //筛选按钮

@end

@implementation SZGoodsManagerController

#pragma mark - getter
- (YPSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[YPSearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.cursorColor = SZColor(45, 119, 253);  //设置光标颜色
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.placeholder = @"请输入商品名称/商品名称首字母搜索";
        _searchBar.textFieldBackgroundColor = SZColor(230, 230, 230);
        _searchBar.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
        _searchBar.delegate = self;
        [_searchBar textField].enablesReturnKeyAutomatically = YES; //无文字输入就不可以点击搜索
    }
    return _searchBar;
}

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
    self.navigationItem.title = @"商品管理";
    self.view.backgroundColor = SZColor(240, 240, 240);
    _sortKind.backgroundColor = SZColor(255, 255, 255);
    UIBarButtonItem *addGoods = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_商品管理_添加商品") selImage:IMAGE_NAMED(@"icon_商品管理_添加商品") target:self action:@selector(addGoodsBtnClick)];
    self.navigationItem.rightBarButtonItem = addGoods;
    
    //添加搜索框
    self.searchBar.frame = CGRectMake(0, 0, kScreenBounds.size.width, 44);
    [_searchView addSubview:_searchBar];
    
    //监听通知
    [self registerForNotifications];
}

- (void)addGoodsBtnClick
{

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
}

//点击排序
- (IBAction)orderBtnClick
{
    if (self.orderIsOpen) {//默认所有属性初始化都为0，即假
        self.OrderTableController.view.height = 0;
    }else{
        self.OrderTableController.view.height = 176;
    }
    self.orderIsOpen = !self.orderIsOpen;
}

//点击筛选
- (IBAction)selectBtnClick
{
    if (self.selectIsOpen) {
        self.SelectTableController.view.height = 0;
    }else{
        self.SelectTableController.view.height = 176;
    }
    self.selectIsOpen = !self.selectIsOpen;
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


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZGoodsManagerCell *goodsManCell = [SZGoodsManagerCell cellWithTableView:tableView];
    //TODO
    
    return goodsManCell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZGoodsDetailController *detailVC = [[SZGoodsDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self unregisterFromNotifications];
}

@end
