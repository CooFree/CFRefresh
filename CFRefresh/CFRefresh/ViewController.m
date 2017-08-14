//
//  ViewController.m
//  CFRefresh
//
//  Created by YF on 2017/8/11.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.data = @[@{
                      @"type":@"QQRefreshTableViewController",
                      @"title":@"仿QQ刷新滴水效果"},
                  @{
                      @"type":@"XHJDRefreshDemoTableViewController",
                      @"title":@"仿京东刷新效果"},
                  @{
                      @"type":@"NewsListTVC",
                      @"title":@"刷新效果"}
                  ];
    [self.view addSubview:self.tableView];

}

- (NSArray *)data {
    if (_data == nil) {
        _data = [NSArray array];
    }
    return _data;
}
- (UITableView *)tableView {
    if(!_tableView){
        UITableView *tab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tab.dataSource = self;
        tab.delegate = self;
        //        tab.backgroundColor = [UIColor whiteColor];
        [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:tab];
        _tableView = tab;
        _tableView.frame=self.view.bounds;
    }
    return _tableView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIViewController *vc = [NSClassFromString(self.data[indexPath.row][@"type"]) new] ;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.data[indexPath.row][@"title"];
    
    return cell;
}

@end
