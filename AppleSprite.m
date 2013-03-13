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
@synthesize weight = _weight;

-(id)initWith:(CGPoint)position
      file:(NSString *)filename
        arrayIndex:(NSUInteger)index
        weightValue:(int)weight
{
    
    self.originalFilename = filename;
    self.originalPosition = position;
    
	self.mySprite =  [CCSprite spriteWithFile:filename];
    self.mySprite.position = ccp(self.originalPosition.x, self.originalPosition.y);
    [self.mySprite setScale:0.5];
    self.putInBasket = NO;
    self.index = index;
    self.weight = weight;
    return self;
}

@end
