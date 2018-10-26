//
//  ViewController.m
//  ZCDemo
//
//  Created by 王璋传 on 2018/10/24.
//  Copyright © 2018 王璋传. All rights reserved.
//

#import "ViewController.h"
#import "ZZAlbumInfoVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender {
    
    ZZAlbumInfoVC *vc = [ZZAlbumInfoVC new];
    vc.view.backgroundColor = UIColor.whiteColor;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
