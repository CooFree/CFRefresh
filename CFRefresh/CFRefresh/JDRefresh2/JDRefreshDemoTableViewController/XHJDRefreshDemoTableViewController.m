//
//  XHJDRefreshDemoTableViewController.m
//  XHRefreshControlExample
//
//  Created by Jack_iMac on 15/4/22.
//  Copyright (c) 2015年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHJDRefreshDemoTableViewController.h"

@interface XHJDRefreshDemoTableViewController ()

@end

@implementation XHJDRefreshDemoTableViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    [self startPullDownRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataSource {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; i ++) {
            [dataSource addObject:@"请问你现在在哪里啊？我在广州天河"];
        }
        
        NSMutableArray *indexPaths;
        if (self.requestCurrentPage) {
            indexPaths = [[NSMutableArray alloc] initWithCapacity:dataSource.count];
            [dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:self.dataSource.count + idx inSection:0]];
            }];
        }
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.requestCurrentPage) {
                if (self.requestCurrentPage == arc4random() % 10) {
                    [self endMoreOverWithMessage:@"段子已加载完"];
                } else {
                    
                    [self.dataSource addObjectsFromArray:dataSource];
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                    [self endLoadMoreRefreshing];
                }
            } else {
                if (rand() % 3 > 1) {
                    self.loadMoreRefreshed = NO;
                }
                
                self.dataSource = dataSource;
                [self.tableView reloadData];
                [self endPullDownRefreshing];
            }
        });
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    if (indexPath.row < self.dataSource.count) {
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    
    return cell;
}

@end
