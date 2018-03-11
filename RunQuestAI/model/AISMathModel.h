//
//  AISMathModel.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 11.03.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AISMathModel : NSObject

+(NSMutableArray *)smoothMedianFor:(NSMutableArray *)array withWindo:(NSUInteger)w;

@end
