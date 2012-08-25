//
//  GameLayer.m
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "GameLayer.h"

@implementation GameLayer

+ (CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init
{
    self = [super init];
	if (self)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor *layerColour = [CCLayerColor layerWithColor:ccc4(128, 0, 128, 255)];
        [self addChild:layerColour];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"hello world" fontName:@"Helvetica" fontSize:17];
		title.position = ccp(winSize.width /2 , winSize.height - 70.0);
        title.color = (ccColor3B){255, 255, 255};
		[self addChild: title];
    }
    return self;
}

@end
