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
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for (int i = 0; i < 4; ++i)
        {
            NSString *name = [NSString stringWithFormat:@"man%d.png", i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: name];
            [walkAnimFrames addObject: frame];
        }
        for (int i = 3; i > 0; --i)
        {
            NSString *name = [NSString stringWithFormat:@"man%d.png", i];
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: name];
            [walkAnimFrames addObject: frame];

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
