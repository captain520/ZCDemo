//
//  TestVC.m
//  ZCDemo
//
//  Created by 王璋传 on 2018/10/24.
//  Copyright © 2018 王璋传. All rights reserved.
//

#import "ZZAlbumInfoVC.h"
#import <MJRefresh.h>

#define SCREEN_WIDTH_F  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT_F ([UIScreen mainScreen].bounds.size.height)

@interface ZZAlbumInfoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UITableView *firstDataTableView, *secondDataTableView;
@property (nonatomic,strong) UIView *toolView;

@end

@implementation ZZAlbumInfoVC {
    CGFloat firstLastOffsetY,secondLastOffsetY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupUI];
}

#pragma mark - initialized base properties
- (void)initializedBaseProperties {
    
}
#pragma mark - setup ui
- (void)setupUI {

    _bgScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _bgScrollView.backgroundColor = [UIColor purpleColor];
    _bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH_F * 2, 0);

    [self.view addSubview:_bgScrollView];
    
    _firstDataTableView = [[UITableView alloc] initWithFrame:self.bgScrollView.bounds style:UITableViewStyleGrouped];
    _firstDataTableView.delegate = self;
    _firstDataTableView.dataSource = self;
    _firstDataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_firstDataTableView.mj_header endRefreshing];
    }];
    
    _firstDataTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [_firstDataTableView.mj_footer endRefreshing];
    }];

    [self.bgScrollView addSubview:_firstDataTableView];
    
    _secondDataTableView = [[UITableView alloc] initWithFrame:CGRectOffset(_bgScrollView.bounds, SCREEN_WIDTH_F, 0) style:UITableViewStyleGrouped];
    _secondDataTableView.delegate = self;
    _secondDataTableView.dataSource = self;
    _secondDataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_secondDataTableView.mj_header endRefreshing];
    }];
    
    _secondDataTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [_secondDataTableView.mj_footer endRefreshing];
    }];

    
    [self.bgScrollView addSubview:_secondDataTableView];
    
    self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_F, 100)];
    self.toolView.backgroundColor = UIColor.greenColor;
    
    [self.view addSubview:self.toolView];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH_F, 40)];
    v.backgroundColor = UIColor.redColor;
    
    [self.toolView addSubview:v];
}
#pragma mark - setter && getter method

#pragma mark - Delegate && Datasource method implement
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"------------------------------";
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    if (scrollView.contentOffset.y > 60) {
        return;
    }
    
    CGRect tempFrame = self.toolView.frame;
    if (scrollView == self.firstDataTableView) {
        
        tempFrame.origin.y -= scrollView.contentOffset.y - firstLastOffsetY;
        firstLastOffsetY = scrollView.contentOffset.y;
        
        [self.secondDataTableView setContentOffset:scrollView.contentOffset];
    } else if (scrollView == self.secondDataTableView) {
        
        tempFrame.origin.y -= scrollView.contentOffset.y - secondLastOffsetY;
        secondLastOffsetY = scrollView.contentOffset.y;
        
        [self.firstDataTableView setContentOffset:scrollView.contentOffset];
    }
    self.toolView.frame = tempFrame;

}

#pragma mark - PrivateMethod

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
