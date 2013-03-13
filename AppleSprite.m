//
//  AppleSprite.m
//  dragDrop2
//
//  Created by vaibhav patel on 3/12/13.
//
//

#import "AppleSprite.h"
@interface AppleSprite()

@end

@implementation AppleSprite
@synthesize originalFilename = _orignalFilename;
@synthesize originalPosition = _originalPosition;
@synthesize mySprite = _mySprite;
@synthesize putInBasket = _putInBasket;
@synthesize index = _index;


-(id)initWith:(CGPoint)position
      file:(NSString *)filename
        arrayIndex:(NSUInteger)index
{
    
    self.originalFilename = filename;
    self.originalPosition = position;
    
	self.mySprite =  [CCSprite spriteWithFile:filename];
    self.mySprite.position = ccp(self.originalPosition.x, self.originalPosition.y);
    self.putInBasket = NO;
    self.index = index;
    return self;
}

@end
