//
//  AISConfiguratorProtocol.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AISConfiguratorProtocolDelegate

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UILabel *paceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *distanceToAimLabel;
@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic, strong) UIButton *mapViewOpenButton;

@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

-(void)configureUI;

@end
