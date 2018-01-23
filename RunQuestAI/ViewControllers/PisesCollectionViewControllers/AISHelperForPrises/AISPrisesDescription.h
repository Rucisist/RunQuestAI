//
//  AISPrisesDescription.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! класс с описанием наград за пробег */
@interface AISPrisesDescription : NSObject

/*! картинки призов */
@property (nonatomic, copy, readonly) NSArray *album;

/*! описание призов */
@property (nonatomic, copy, readonly) NSArray *albumDescription;

/*! дистанция для получения приза */
@property (nonatomic, copy, readonly) NSArray *albumHelper;

@end
