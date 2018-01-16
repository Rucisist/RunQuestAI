//
//  AILModelFo/Users/Andrew_Ilalov/Desktop/xcode/RunQuestAI/RunQuestAI/Assets.xcassetsrFirstController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ColorUpdatable.h"

@interface AILModelForFirstController : NSObject

@property (nonatomic, strong) id <ColorUpdatable> viewController;
-(void)backgroundColorChange:(UIView *)view  toColor: (UIColor *)color;


@end
