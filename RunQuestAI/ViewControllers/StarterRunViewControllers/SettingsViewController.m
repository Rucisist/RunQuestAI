//
//  SettingsViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (nonatomic, strong) UIButton *exitButton;
@property (nonatomic) CGFloat viewHeight;
@property (nonatomic) CGFloat viewWidth;
@property (nonatomic, strong) UIButton *themeControllButton;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewWidth = CGRectGetWidth(self.view.frame);
    self.viewHeight = CGRectGetHeight(self.view.frame);
    [self configureSettingsUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureSettingsUI
{
    [self configurateExitButton];
    [self configurateThemeControllButton];
}

-(void)configurateExitButton
{
    self.exitButton = [UIButton new];
    [self configurateButtonWithCGRect:CGRectMake(self.viewWidth - 50, 50, 50, 50) forButton:self.exitButton];
    self.exitButton.backgroundColor = [UIColor yellowColor];
    [self.exitButton setTitle:@"X" forState:UIControlStateNormal];
    
    [self.view addSubview:self.exitButton];
    [self.exitButton addTarget:self action:@selector(dismissSettingsViewController) forControlEvents:UIControlEventTouchUpInside];
}

-(void)configurateThemeControllButton
{
    self.themeControllButton = [UIButton new];
    
    [self configurateButtonWithCGRect:CGRectMake(self.viewWidth - 200, 50, 50, 50) forButton:self.themeControllButton];
    
    [self.exitButton addTarget:self action:@selector(dismissSettingsViewController) forControlEvents:UIControlEventTouchUpInside];
}



-(void)configurateButtonWithCGRect: (CGRect)rect forButton: (UIButton*)button
{
    button.frame = rect;
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
}

-(void)dismissSettingsViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
