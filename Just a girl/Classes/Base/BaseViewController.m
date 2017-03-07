//
//  BaseViewController.m
//  Just a girl
//
//  Created by xiang on 16/5/5.
//  Copyright © 2016年 xiang. All rights reserved.
//


#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - life cycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (kIOS7OrLater) {
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self swipeBackGestureRecognizer];
        [self setLeftBarButton];
    }
    
    UITapGestureRecognizer *navTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigationBarAction)];
    navTap.numberOfTapsRequired = 1;
    [self.navigationController.navigationBar addGestureRecognizer:navTap];
    
    _label = [UILabel new];
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.font = [UIFont systemFontOfSize:kDefaultFontSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"dealloc:%@", self);
}

#pragma mark - event responds
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightSwipeGestureAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationBarAction {
    
}

#pragma mark - private methods
- (void)setLeftBarButton {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"返回S"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kLeftMargin;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:space, backItem,  nil]];
}

- (void)showTabBar {
    if (self.tabBarController.tabBar.hidden == NO) {
        return;
    }
    
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }else{
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, contentView.bounds.size.height);
    self.tabBarController.tabBar.hidden = NO;
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }else{
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, contentView.bounds.size.height);
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setRightBarButtonWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage withBlock:(TouchedBlock)block {
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, kNavBarHeight/2 - image.size.height/2, image.size.width, image.size.height);
    [rightBarButton setImage:image forState:UIControlStateNormal];
    [rightBarButton setImage:highlightedImage forState:UIControlStateHighlighted];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBarButton addActionHandler:^(NSInteger tag) {
        block(tag);
    }];
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kRightMargin;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rItem,space, nil];
}

- (void)setRightBarButtonWithTitle:(NSString *)title withBlock:(TouchedBlock)block {
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, kNavBarHeight + 20, kNavBarHeight);
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBarButton setTitle:title forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBarButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBarButton addActionHandler:^(NSInteger tag) {
        block(tag);
    }];
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kRightMargin;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rItem,space, nil];
}

- (void)setRightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color withBlock:(TouchedBlock)block {
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, kNavBarHeight + 20, kNavBarHeight);
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBarButton setTitle:title forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBarButton setTitleColor:color forState:UIControlStateNormal];
    [rightBarButton addActionHandler:^(NSInteger tag) {
        block(tag);
    }];
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kRightMargin;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rItem, space, nil];
}

- (void)setLeftBarButtonWithImage:(UIImage *)image withHighlightedImage:(UIImage *)highlightedImage withBlock:(TouchedBlock)block {
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, kNavBarHeight/2 - image.size.height/2, image.size.width, image.size.height);
    [leftBarButton setImage:image forState:UIControlStateNormal];
    [leftBarButton setImage:highlightedImage forState:UIControlStateHighlighted];
    leftBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBarButton addActionHandler:^(NSInteger tag) {
        block(tag);
    }];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kLeftMargin;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:space,backItem, nil]];
}

- (void)setLeftBarButtonWithTitle:(NSString *)title withBlock:(TouchedBlock)block {
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, kNavBarHeight, kNavBarHeight);
    leftBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBarButton setTitle:title forState:UIControlStateNormal];
    leftBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBarButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBarButton addActionHandler:^(NSInteger tag) {
        block(tag);
    }];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kLeftMargin;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:space,backItem, nil]];
}

- (void)setLeftBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color withBlock:(TouchedBlock)block {
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, kNavBarHeight, kNavBarHeight);
    leftBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBarButton setTitle:title forState:UIControlStateNormal];
    leftBarButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBarButton setTitleColor:color forState:UIControlStateNormal];
    [leftBarButton addActionHandler:^(NSInteger tag) {
        block(tag);
    }];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kLeftMargin;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:space,backItem, nil]];
}

- (void)setLeftBarButtonWithImage:(UIImage *)image withHighLightedImage:(UIImage *)highlightedImage {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = kLeftMargin;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:space,backItem, nil]];
}

- (void)swipeBackGestureRecognizer {
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] init];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [rightSwipeGesture addTarget:self action:@selector(rightSwipeGestureAction)];
    [self.view addGestureRecognizer:rightSwipeGesture];
}


@end
