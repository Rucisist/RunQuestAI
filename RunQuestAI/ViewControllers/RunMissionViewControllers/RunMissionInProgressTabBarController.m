//
//  RunMissionInProgressTabBarController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "RunMissionInProgressTabBarController.h"
#import "RunMissionMapViewController.h"
#import "RunMissionCharacteristicsViewController.h"

@interface RunMissionInProgressTabBarController ()

@property (nonatomic,strong) RunMissionMapViewController *mapViewController;
@property (nonatomic, strong) RunMissionCharacteristicsViewController *characteristicsViewController;

@end

@implementation RunMissionInProgressTabBarController

- (void)viewDidLoad {
    self.mapViewController = [RunMissionMapViewController new];
    self.characteristicsViewController = [RunMissionCharacteristicsViewController new];
    
    UITabBarItem *leftTabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:0];
    UITabBarItem *rightTabBarItem = [[UITabBarItem alloc] initWithTitle:@"231" image:[UIImage imageNamed:@"runbuttonImageLittle"] tag:1];

    
    self.mapViewController.tabBarItem = leftTabBarItem;
    self.characteristicsViewController.tabBarItem = rightTabBarItem;
    
    NSArray *tabBarControllers = @[self.characteristicsViewController, self.mapViewController];
    
    self.viewControllers = tabBarControllers;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
