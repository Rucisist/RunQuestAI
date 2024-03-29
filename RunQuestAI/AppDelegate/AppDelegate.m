//
//  AppDelegate.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 12.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AppDelegate.h"
#import "AISBeginRunViewController.h"
#import "AISCountdownRunMissionViewController.h"
#import "AISMainViewTabbarController.h"
#import "AISWeatherForRunAndClothesViewController.h"
#import "AISNavigationControllerDelegate.h"
@import GoogleMaps;

@interface AppDelegate ()

@property (nonatomic,strong) id <UINavigationControllerDelegate> globalNavBarDelegate;

@end

static NSString *const GMSServicesKey = @"AIzaSyBacMb-sv6VxaYjoZHJV9D6c4c_iyBhdak";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //added Google Maps Kit and Google Places
    [GMSServices provideAPIKey:GMSServicesKey];
    //*****
    
    //configure window
    self.window = UIWindow.new;
    
    //создается начальный viewController
    UINavigationController *navigationController = [UINavigationController.alloc initWithRootViewController:AISMainViewTabbarController.new];
    self.globalNavBarDelegate = AISNavigationControllerDelegate.new;

    //navigationController.delegate = self.globalNavBarDelegate;
    [navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [UIImage new];
    navigationController.navigationBar.translucent = YES;
    
    self.window.rootViewController = navigationController; //[AISWeatherForRunAndClothesViewController new];
    [self.window makeKeyAndVisible];
        
    return YES;
}

@end
