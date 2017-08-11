//
//  QQRefreshTableViewController.m
//  CFRefresh
//
//  Created by YF on 2017/8/11.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "QQRefreshTableViewController.h"
#import "TGRefresh.h"

@interface QQRefreshTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QQRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

    [self buildBest];
}

-(void)buildBest{
    //默认为QQ效果
    self.tableView.tg_header = [TGRefreshOC  refreshWithTarget:self action:@selector(doRefreshSenior) config:nil];
//    [self.tableView.tg_header beginRefreshing];
}
- (void)doRefreshSenior{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableView.tg_header.refreshResultStr = @"成功刷新数据来自高级用法";
        [self.tableView.tg_header endRefreshing];
    });
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行测试数据",(long)indexPath.row];
    return cell;
}
- (UITableView *)tableView {
    if(!_tableView){
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tab.dataSource = self;
        tab.delegate = self;
        //        tab.backgroundColor = [UIColor whiteColor];
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [self.view addSubview:tab];
        _tableView = tab;
        _tableView.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    }
    return _tableView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
