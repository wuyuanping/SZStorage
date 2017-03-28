//
//  SZInputController.m
//  SZStorage
//
//  Created by 吴园平 on 21/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZInputController.h"
#import "SZSelectController.h"
#import "SZOrderController.h"
#import "YPSearchBar.h"
#import "SZCoverView.h"
#import "SZSortKindButton.h"
#import "SZGoodsInputCell.h"
#import "SZGoodsInputHeaderView.h"

@interface SZInputController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) YPSearchBar *searchBar;
@property (nonatomic,strong) SZOrderController *OrderTableController;//排序
@property (nonatomic,strong) SZSelectController *SelectTableController;//筛选
@property (nonatomic,strong) SZCoverView *coverView;
@property (nonatomic,assign) BOOL orderIsOpen;
@property (nonatomic,assign) BOOL selectIsOpen;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *sortKind;
@property (weak, nonatomic) IBOutlet SZSortKindButton *orderBtn; //排序按钮
@property (weak, nonatomic) IBOutlet SZSortKindButton *selectBtn; //筛选按钮

@property (weak, nonatomic) IBOutlet UIButton *sureInputBtn;

@property (weak, nonatomic) IBOutlet SZBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) BOOL *isOpen;
@property (nonatomic,assign) NSIndexPath *selectIndex;

@end

@implementation SZInputController

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
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"商品入库";
    self.view.backgroundColor = SZColor(240, 240, 240);
    _sortKind.backgroundColor = SZColor(255, 255, 255);
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    //添加搜索框
    self.searchBar.frame = CGRectMake(0, 0, kScreenBounds.size.width, 44);
    [_searchView addSubview:_searchBar];
    
    //监听通知
    [self registerForNotifications];
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

#pragma mark - 搜索框 getter
- (YPSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[YPSearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.cursorColor = SZColor(45, 119, 253);  //设置光标颜色
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.placeholder = @"请输入商品名称/商品首字母搜索";
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
    [searchBar resignFirstResponder];
    if(_searchBar.text.length){
        [SVProgressHUD showInfoWithStatus:@"暂时无法搜索"];
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

//确定入库按钮
- (IBAction)sureInputBtnClick
{

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

#pragma mark - UITableViewDatasource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (_isOpen && _selectIndex.section == section) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isOpen && _selectIndex.section == indexPath.section && indexPath.row != 0) {
        return 224;
    }
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self gerenateTablecell:tableView indexpath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *)gerenateTablecell:(UITableView *)tableView
                            indexpath:(NSIndexPath *)indexpath
{
    
    if (_isOpen && _selectIndex.section == indexpath.section && indexpath.row != 0) {
        SZGoodsInputCell *cell = [SZGoodsInputCell cellWithTableView:tableView];
        return cell;
        }else{
        SZGoodsInputHeaderView *headerCell = [SZGoodsInputHeaderView cellWithTableView:tableView];
            return headerCell;
        }
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGRect rect = [self.tableView rectForRowAtIndexPath:indexPath];
//    NSLog(@"点击cell:%@",NSStringFromCGRect(rect));
    if (indexPath.row == 0) {
        /**
         *  expand cell select method
         */
        if ([indexPath isEqual:_selectIndex]) {
            _isOpen = (BOOL *)NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            _selectIndex = nil;
        }else{
            if (!_selectIndex) {
                _selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
            }else{
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert
                         nextDo:(BOOL)nextDoInsert
{
    _isOpen = (BOOL *)firstDoInsert;
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:_selectIndex.section];
    [rowToInsert addObject:indexPathToInsert];
    [_tableView beginUpdates];
    if (firstDoInsert)
    {
        [_tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        [_tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }
    [_tableView endUpdates];
    if (nextDoInsert) {
        _isOpen = (BOOL *)YES;
        _selectIndex = [_tableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (_isOpen){
        [_tableView scrollToRowAtIndexPath:_selectIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)startAnimation:(UIImageView *)view Up:(BOOL)up
              complete:(void(^)())block
{
    if (up) {
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            if (block) {
                block();
            }
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            if (block) {
                block();
            }
        }];
    }
}





























- (void)dealloc
{
    [self unregisterFromNotifications];
}

@end
