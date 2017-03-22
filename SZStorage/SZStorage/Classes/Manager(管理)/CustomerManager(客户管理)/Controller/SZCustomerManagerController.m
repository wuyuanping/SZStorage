//
//  SZCustomerManagerController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCustomerManagerController.h"
#import "SZCustomerManagerCell.h"
#import "SZNewBulidCustomerController.h"
#import "SZCustomerDetailController.h"
#import "SZCustomerItem.h"
#import "SZLoginViewController.h"

@interface SZCustomerManagerController ()
@property (nonatomic,strong) NSMutableArray *ItemArray;

//用户保存总页数
//@property (nonatomic,copy) NSString *maxPage;
@property (nonatomic, weak) AFHTTPSessionManager *mgr; //解决上下拉刷新。


@end
static NSString *username = nil;
//static NSInteger pageIndex = 1;
@implementation SZCustomerManagerController

- (NSMutableArray *)ItemArray
{
    if (!_ItemArray) {
        _ItemArray = [NSMutableArray array];
    }
    return _ItemArray;
}

- (AFHTTPSessionManager *)mgr{
    
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self loadNewData];
    // 2.添加上下拉刷新
    [self setupRefreshView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setup
{
    self.navigationItem.title = @"客户管理";
    UIBarButtonItem *pencil = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_商品管理_编辑") selImage:IMAGE_NAMED(@"icon_商品管理_编辑") target:self action:@selector(newBulidBtnClick)];
    self.navigationItem.rightBarButtonItems = @[pencil];
    [SVProgressHUD showWithStatus:@"正在加载数据"];
}

- (void)loadNewData
{
    // 1.取消之前请求（解决上下拉刷新冲突！！！）
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSLog(@"%@",username);
    NSDictionary *dic = @{
                          @"username":username,
                          @"shop_no":@(10),
                          @"key_word":@"",
                          @"page_num":@(1),
                          @"page_size":@(10)
                          };
    YPWeakSelf ;
    // 2.发送请求
    [self.mgr POST:selectCustomerUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        if([responseObject[@"code"] isEqual:@(0)]){
            NSLog(@"查询成功");
            [SVProgressHUD dismiss];
            //结束头部刷新
            [self.tableView.mj_header endRefreshing];
           //保存总页数
//            _maxPage = responseObject[@"all_page"];
            NSLog(@"responseObject = %@",responseObject);
            if (responseObject[@"data"][@"datalist"]) {
                self.ItemArray = [SZCustomerItem  mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datalist"]];
                [weakSelf.tableView reloadData];
            }else{
                return ;
            }
        }else{
            NSLog(@"查询失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 添加上下拉刷新
- (void)setupRefreshView
{
    //添加下拉刷新：
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    
    //添加上拉刷新：
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
}

- (void)loadMoreData
{
//    pageIndex ++;
//    if (pageIndex == _maxPage + 1) {
//        pageIndex = 1;
//    }
    // 1.取消之前请求（解决上下拉刷新冲突）
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //2.发送请求
    NSDictionary *dic = @{
                          @"username":username,
                          @"shop_no":@(10),
                          @"key_word":@"",
                          @"page_num":@(2),
                          @"page_size":@(10)
                          };
    YPWeakSelf ;
    // 2.发送请求
    [self.mgr POST:selectCustomerUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"code"] isEqual:@(0)]){
            NSLog(@"查询成功");
            [SVProgressHUD dismiss];
            //结束尾部刷新
            [self.tableView.mj_footer endRefreshing];
            NSLog(@"responseObject = %@",responseObject);
            if (responseObject[@"data"][@"datalist"]) {
                self.ItemArray = [SZCustomerItem  mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datalist"]];
                [weakSelf.tableView reloadData];
            }else{
                return ;
            }
        }else{
            NSLog(@"查询失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)newBulidBtnClick
{
    SZNewBulidCustomerController *newBuildVC = [[SZNewBulidCustomerController alloc] init];
    [self.navigationController pushViewController:newBuildVC animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _ItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZCustomerManagerCell *cell = [SZCustomerManagerCell cellWithTableView:tableView];
    cell.item = _ItemArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZCustomerDetailController *customerDetVC = [[SZCustomerDetailController alloc] init];
//    customerDetVC.item = _ItemArray[indexPath.row];
    [self.navigationController pushViewController:customerDetVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
