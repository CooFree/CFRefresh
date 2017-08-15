//
//  WritingRefreshViewController.m
//  CFRefresh
//
//  Created by YF on 2017/8/14.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "WritingRefreshViewController.h"
#import "PDPullToRefresh.h"

@interface WritingRefreshViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WritingRefreshViewController
- (void)dealloc {

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);

    [self addPDRefresh];
}
- (void)addPDRefresh
{
    __weak typeof(self) weakSelf = self;

    [self.tableView pd_addHeaderRefreshWithNavigationBar:NO andActionHandler:^{
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"Header - ActionHandler");
            [weakSelf.tableView.pdHeaderRefreshView stopRefreshing];
        });
    }];
    //    [self.tableView.pdHeaderRefreshView startRefreshing];

    [self.tableView pd_addFooterRefreshWithNavigationBar:NO andActionHandler:^{
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"Footer - ActionHandler");
            [weakSelf.tableView.pdFooterRefreshView stopRefreshing];
        });
    }];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld条",(long)indexPath.row];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
