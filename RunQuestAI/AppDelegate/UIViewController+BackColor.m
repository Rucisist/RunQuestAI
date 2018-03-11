//
//  UIViewController+BackColor.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 08.03.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "UIViewController+BackColor.h"

@implementation UIViewController (BackColor)

-(void)creategRightNavigationButton
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"title" style:UIBarButtonItemStyleDone target:self action:@selector(ac)];
}

-(void)ac
{
    
}

@end
