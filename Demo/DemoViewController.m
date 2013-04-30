//
//  DemoViewController.m
//  Demo
//
//  Created by Hirohisa Kawasaki on 13/04/30.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import "DemoViewController.h"
#import "UIColor+Hex.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *l0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    l0.text = @"336699";
    l0.textColor = [UIColor colorWithHexRGB:336699];
    [self.view addSubview:l0];

    UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 50)];
    l1.text = @"559900";
    l1.textColor = [UIColor colorWithHexString:@"#559900"];
    l1.backgroundColor = [UIColor webViewBackgroundColor];
    [self.view addSubview:l1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
