//
//  HelloWorldLayer.m
//  dragDrop2
//
//  Created by vaibhav patel on 3/12/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "AppleSprite.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer
#include <math.h>

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init {
    if((self = [super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"blue-shooting-stars_portrait.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        basket = [CCSprite spriteWithFile:@"Icon@2x.png"];
        basket.anchorPoint = ccp(0,0);
        basket.position = ccp(winSize.width - basket.contentSize.width,10);
        [self addChild:basket];
        
        movableSprites = [[NSMutableArray alloc] init];
        NSArray *images = [NSArray arrayWithObjects:@"bird.png", @"cat.png", @"dog.png", @"turtle.png", nil];

        
        
        float center_y = winSize.height/2;
        float center_x = winSize.width/2;
        float radius = 50.0;
        float theta = 0.0;
        
        for(int i = 0; i < images.count; ++i) {
            
            NSString *image = [images objectAtIndex:i];
            
            //float offsetFraction = ((float)(i+1))/(images.count+1);
            
            theta = (i+1)*(360/images.count);
            float cosTheta = cos(theta *(M_PI/180));
            float sinTheta = sin(theta *(M_PI/180));
            
            double x = center_x + radius * cosTheta;
            double y = center_y + radius * sinTheta;
            CGPoint position = {x,y};

            //AppleSprite *apple = [[AppleSprite alloc]initWith:position File:image arrayIndex:i];
            AppleSprite *apple = [[AppleSprite alloc]initWith:position file:image arrayIndex:i];
            [self addChild:apple.mySprite];
            [movableSprites addObject:apple];
        }
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

    }
    return self;
}
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    AppleSprite * newSprite = nil;
    for (AppleSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.mySprite.boundingBox, touchLocation)) {
            newSprite = sprite;
            break;
        }
    }
    if (newSprite.mySprite != selSprite.mySprite) {
        [selSprite.mySprite stopAllActions];
        [selSprite.mySprite runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        [newSprite.mySprite runAction:[CCRepeatForever actionWithAction:rotSeq]];
        selSprite =  newSprite;
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}


- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -background.contentSize.width+winSize.width);
    retval.y = self.position.y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    if (selSprite.mySprite) {
        CGPoint newPos = ccpAdd(selSprite.mySprite.position, translation);
        selSprite.mySprite.position = newPos;
        //TODO: logic to put current toy in bin and create new toy
        if (CGRectContainsPoint(basket.boundingBox, newPos))
        {
            if(!selSprite.putInBasket){
                NSLog(@"TouchDown");
                AppleSprite *apple = [[AppleSprite alloc]initWith:selSprite.originalPosition
                                                         file:selSprite.originalFilename
                                                        arrayIndex:selSprite.index];
                
                [movableSprites replaceObjectAtIndex:selSprite.index withObject:apple];
                selSprite.putInBasket = YES;
                
                [self addChild:apple.mySprite];
            }
        }
    } else {
        CGPoint newPos = ccpAdd(self.position, translation);
        self.position = [self boundLayerPos:newPos];
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    [movableSprites release];
    movableSprites = nil;
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
