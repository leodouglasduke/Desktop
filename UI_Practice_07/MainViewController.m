
//
//  MainViewController.m
//  UI_Practice_07
//
//  Created by DukeMou on 15/4/27.
//  Copyright (c) 2015年 河南蓝鸥科技有限公司. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, retain) UIView *testView;

@end

@implementation MainViewController

- (void)dealloc {
    [_testView release];
    [super dealloc];
}

- (UIView *)testView {
    if (!_testView) {
        self.testView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
        _testView.backgroundColor = [UIColor redColor];
    }
    return _testView;
}

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.testView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.testView addGestureRecognizer:pan];
    [pan release];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.testView.bounds), CGRectGetHeight(self.testView.bounds))];
    aLabel.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1];
    aLabel.font = [UIFont systemFontOfSize:100];
    aLabel.adjustsFontSizeToFitWidth = YES;
    aLabel.text = [NSString stringWithFormat:@"第1个label"];
    [self.testView addSubview:aLabel];
    [aLabel release];
    
    
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    CGPoint currentPoint = [sender translationInView:self.view];
    CGRect bounds = self.testView.bounds;
    bounds.origin.x -= currentPoint.x;
    self.testView.bounds = bounds;
    [sender setTranslation:CGPointZero inView:self.view];
    NSLog(@"%@", NSStringFromCGRect(self.testView.bounds));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
