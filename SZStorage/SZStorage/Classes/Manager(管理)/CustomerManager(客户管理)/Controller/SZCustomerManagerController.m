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
@property (nonatomic,assign) NSInteger maxPage;
@property (nonatomic, weak) AFHTTPSessionManager *mgr; //解决上下拉刷新冲突。

@end
static NSString *username = nil;
static NSString *shop_no = nil;
static NSInteger pageIndex = 1;

@implementation SZCustomerManagerController

- (NSMutableArray *)ItemArray
{
    if (!_ItemArray) {
        _ItemArray = [NSMutableArray array];
    }
    return _ItemArray;
}

- (AFHTTPSessionManager *)mgr
{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
    //一进来和回到这里都会来
   BOOL isSaved = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCustomer"];
    if (isSaved) {
//        [self loadNewData];
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)setup
{
    self.navigationItem.title = @"客户管理";
    UIBarButtonItem *newBuild = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_商品管理_新建客户") selImage:IMAGE_NAMED(@"icon_商品管理_新建客户") target:self action:@selector(newBulidBtnClick)];
    self.navigationItem.rightBarButtonItem = newBuild;
    // 添加上下拉刷新控件
    [self setupRefreshView];
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

- (void)loadNewData
{
    // 1.取消之前请求（解决上下拉刷新冲突！！！）
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    shop_no = [[NSUserDefaults standardUserDefaults] objectForKey:@"shop_no"];
    NSDictionary *dic = @{
                          @"username":username,
                          @"shop_no":shop_no,
                          @"key_word":@"",
                          @"page_num":@(1),
                          @"page_size":@(10)
                          };
    YPWeakSelf ;
    // 2.发送请求
    self.mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.mgr POST:selectCustomerUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if([responseObject[@"code"] isEqual:@(0)]){
            NSLog(@"查询成功");
            //结束头部刷新
            [self.tableView.mj_header endRefreshing];
            NSLog(@"responseObject = %@",responseObject[@"data"]);
            if (responseObject[@"data"]) {
                //保存总页数
                _maxPage = (NSInteger)responseObject[@"data"][@"all_page"];
                self.ItemArray = [SZCustomerItem  mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datalist"]];
                [weakSelf.tableView reloadData];
                if (pageIndex == _maxPage) {
                    //移除尾部刷新控件
                    self.tableView.mj_footer.hidden = YES;
                    return ;
                }
            }else{
                NSLog(@"没有数据");
                return ;
            }
        }else{
            NSLog(@"查询失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadMoreData
{
    pageIndex ++;
    
    // 1.取消之前请求（解决上下拉刷新冲突）
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //2.发送请求
    NSDictionary *dic = @{
                          @"username":username,
                          @"shop_no":shop_no,
                          @"key_word":@"",
                          @"page_num":@(pageIndex),
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
            if (responseObject[@"data"]) {
                self.ItemArray = [SZCustomerItem  mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datalist"]];
                [weakSelf.tableView reloadData];
            }else{
                NSLog(@"没有数据");
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
