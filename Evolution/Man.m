//
//  Man.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "Man.h"

@implementation Man

- (id) init
{
    self = [super init];
    if (self)
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"man.plist"];
        
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"man.png"];
        [self addChild:spriteSheet];
        
        NSArray *names = [NSArray arrayWithObjects:@"man0.png"
                          , @"man1.png"
                          , @"man2.png"
                          , @"man3.png"
                          , @"man2.png"
                          , @"man1.png"
                          , nil];
        
        int index = arc4random()%[names count];
        NSMutableArray *walkAnimFrames = [NSMutableArray arrayWithCapacity:7];
        for (int i = 0; i < [names count]; ++i)
        {
            
            NSString *name = [names objectAtIndex:index];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: name];
            [walkAnimFrames addObject: frame];
            
            if (++index >= [names count])
            {
                index = 0;
            }
        }
        CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.2f];
        
        
        CCSprite *explode = [CCSprite spriteWithSpriteFrameName:@"man0.png"];
        
        CCAction *walkAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
        
        [explode runAction:walkAction];
        [spriteSheet addChild:explode];
    }
    return self;
}
@end
