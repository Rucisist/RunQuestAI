//
//  AISImageResizer.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 07.02.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AISImageResizer : NSObject

- (UIImage *)scaleImage:(UIImage *)originalImage toSize:(CGSize)size;
- (UIImage *)scaleImage:(UIImage *)image proportionallyToSize:(CGSize)newSize;

@end
