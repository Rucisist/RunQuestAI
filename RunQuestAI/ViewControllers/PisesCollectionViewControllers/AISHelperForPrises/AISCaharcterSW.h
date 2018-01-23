//
//  AISCaharcterSW.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 20.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!@brief класс персонажей */
@interface AISCaharcterSW : NSObject

/*!@brief имя персонажа */
@property (nonatomic, strong) NSString *characterDescription;

/*!@brief фото персонажа */
@property(nonatomic,strong) UIImage *characterImage;

@end
