//
//  SZOutputListController.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZOutputListController.h"
#import "YPSearchBar.h"
#import "SZCoverView.h"
#import "SZOutputListCell.h"

@interface SZOutputListController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet SZBaseTableView *tableView;
@property (nonatomic, strong) YPSearchBar *searchBar;
@property (nonatomic,strong) SZCoverView *coverView;
//出库单为空时显示的View
@property (weak, nonatomic) IBOutlet UIView *noneContentView;

@end

@implementation SZOutputListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp
{
    self.navigationItem.title = @"出库单";
    self.view.backgroundColor = SZColor(240, 240, 240);
    [self setNavigationBarBackgroundImage:IMAGE_NAMED(@"icon_导航条") tintColor:SZColor(46, 144, 255) textColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
    
    //添加搜索框
    self.searchBar.frame = CGRectMake(0, 0, kScreenBounds.size.width, 44);
    [_searchView addSubview:_searchBar];
    _noneContentView.hidden = YES;
}

#pragma mark - 搜索框 getter
- (YPSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[YPSearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.cursorColor = SZColor(45, 119, 253);  //设置光标颜色
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.placeholder = @"请输入商品名称/出库单号搜索";
        _searchBar.textFieldBackgroundColor = SZColor(230, 230, 230);
        _searchBar.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
        _searchBar.delegate = self;
        [_searchBar textField].enablesReturnKeyAutomatically = YES; //无文字输入就不可以点击搜索
    }
    return _searchBar;
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZOutputListCell *cell = [SZOutputListCell cellWithTableView:tableView];
    // TODO
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
