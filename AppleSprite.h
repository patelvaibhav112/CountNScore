//
//  AppleSprite.h
//  dragDrop2
//
//  Created by vaibhav patel on 3/12/13.
//
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AppleSprite:NSObject
@property (strong, nonatomic)CCSprite * mySprite;
@property (strong, nonatomic) NSString* originalFilename;
@property (assign,nonatomic) CGPoint originalPosition;
@property (assign, nonatomic) BOOL putInBasket;
@property (assign,nonatomic) NSUInteger index;
-(id)initWith:(CGPoint)position
         file:(NSString *)filename
   arrayIndex:(NSUInteger)index;
@end
