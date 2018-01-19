//
//  MainViewTabbarController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "MainViewTabbarController.h"
#import "BeginRunViewController.h"
#import "StatsViewController.h"
#import "PrisesCollectionViewController.h"
#import "PrisesPagesViewController.h"

@interface MainViewTabbarController ()

//@property (nonatomic, strong) BeginRunViewController *beginRunViewController;
@property (nonatomic, strong) StatsViewController *statsViewController;
@property (nonatomic, strong) PrisesCollectionViewController *prisesCollectionViewController;
@property (nonatomic, strong) PrisesPagesViewController *prisesPagesViewController;

@end

@implementation MainViewTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabBarWithViewControllers];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureTabBarWithViewControllers
{
    BeginRunViewController *beginRunViewController = [BeginRunViewController new];
    self.statsViewController = [StatsViewController new];
    self.prisesCollectionViewController = [PrisesCollectionViewController new];
    self.prisesPagesViewController = [PrisesPagesViewController new];
    

    
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:@"run" image:[UIImage imageNamed:@"road"] tag:0];
    UITabBarItem *rightTabBarItem = [[UITabBarItem alloc] initWithTitle:@"stats" image:[UIImage imageNamed:@"runbuttonImageLittle"] tag:1];
    UITabBarItem *thirdTabBarItem = [[UITabBarItem alloc] initWithTitle:@"prises" image:[UIImage imageNamed:@"medal"] tag:2];
    
  //  UITabBarItem *forthTabBarItem = [[UITabBarItem alloc] initWithTitle:@"prises2" image:[UIImage imageNamed:@"runbuttonImageLittle"] tag:3];
    

    
    
    beginRunViewController.tabBarItem = firstItem;
//    self.characteristicsViewController.tabBarItem = rightTabBarItem;
    self.statsViewController.tabBarItem = rightTabBarItem;
    self.prisesCollectionViewController.tabBarItem = thirdTabBarItem;
    //self.prisesPagesViewController.tabBarItem = forthTabBarItem;
    
    NSArray *tabBarControllers = @[beginRunViewController, self.statsViewController, self.prisesCollectionViewController];
    
    self.viewControllers = tabBarControllers;
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
