//
//  RunMissionInProgressTabBarController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISRunMissionInProgressTabBarController.h"
#import "AISRunMissionMapViewController.h"
#import "AISRunMissionCharacteristicsViewController.h"

@interface AISRunMissionInProgressTabBarController ()

@property (nonatomic, strong) AISRunMissionMapViewController *mapViewController;
@property (nonatomic, strong) AISRunMissionCharacteristicsViewController *characteristicsViewController;

@end

@implementation AISRunMissionInProgressTabBarController

- (void)viewDidLoad {
    self.mapViewController = [AISRunMissionMapViewController new];
    self.characteristicsViewController = [AISRunMissionCharacteristicsViewController new];
    
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
