//
//  SZSupplierManagerController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSupplierManagerController.h"
#import "SZSupplierManagerCell.h"
#import "SZSupplierDetailController.h"
#import "SZNewBuildSupplierController.h"
#import "SZSupplierItem.h"

@interface SZSupplierManagerController ()
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) AFHTTPSessionManager *mgr;
//用户保存总页数
@property (nonatomic,assign) NSInteger maxPage;
@end

static NSString *username = nil;
static NSString *shop_no = nil;
static NSInteger pageIndex = 1;
@implementation SZSupplierManagerController

- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
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
    [self loadNewData];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setup
{
    self.navigationItem.title = @"供应商管理";
    UIBarButtonItem *newBuildSupplier = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_商品管理_新建供应商") selImage:IMAGE_NAMED(@"icon_商品管理_新建供应商") target:self action:@selector(newBuildSupplierClick)];
    self.navigationItem.rightBarButtonItem = newBuildSupplier;
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
                          @"page_num":@(pageIndex),
                          @"page_size":@(10)
                          };
    YPWeakSelf ;
    // 2.发送请求
    self.mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.mgr POST:supplierSelectUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if([responseObject[@"code"] isEqual:@(0)]){
            NSLog(@"查询成功");
            //结束头部刷新
            [self.tableView.mj_header endRefreshing];
            NSLog(@"responseObject = %@",responseObject[@"data"]);
            if (responseObject[@"data"]) {
                //保存总页数
                _maxPage = (NSInteger)responseObject[@"data"][@"all_page"];
                self.itemArray = [SZSupplierItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datalist"]];
                [weakSelf.tableView reloadData];
                    //移除尾部刷新控件
                self.tableView.mj_footer.hidden = (pageIndex == _maxPage)? YES : NO;
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
    username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    shop_no = [[NSUserDefaults standardUserDefaults] objectForKey:@"shop_no"];
    NSDictionary *dic = @{
                          @"username":username,
                          @"shop_no":shop_no,
                          @"key_word":@"",
                          @"page_num":@(pageIndex),
                          @"page_size":@(10)
                          };

    YPWeakSelf ;
    // 2.发送请求
    [self.mgr POST:supplierSelectUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"code"] isEqual:@(0)]){
            NSLog(@"查询成功");
            //结束尾部刷新
            [self.tableView.mj_footer endRefreshing];
            NSLog(@"responseObject = %@",responseObject);
            NSLog(@"%@",responseObject[@"data"]);
            self.itemArray = [SZSupplierItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datalist"]];
                [weakSelf.tableView reloadData];
            }else{
                NSLog(@"没有数据");
                return ;
            }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)newBuildSupplierClick
{
    SZNewBuildSupplierController *newBuildSupVC = [[SZNewBuildSupplierController alloc] init];
    [self.navigationController pushViewController:newBuildSupVC animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZSupplierManagerCell *cell = [SZSupplierManagerCell cellWithTableView:tableView];
    cell.item = _itemArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZSupplierDetailController *supplierDeVC = [[SZSupplierDetailController alloc] init];
    [self.navigationController pushViewController:supplierDeVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
