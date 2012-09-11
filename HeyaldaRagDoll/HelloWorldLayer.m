//
//  RootViewController.m
//  HeyaldaRagDoll
//
//  Created by Jim Range on 7/16/12.
//  Copyright 2012 Heyalda Corporation 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Class that enables creating a Ragdoll
#import "RagDollCharacter.h"


enum {
	kTagParentNode = 1,
};

// callback to remove Shapes from the Space
void removeShape( cpBody *body, cpShape *shape, void *data )
{
	cpShapeFree( shape );
}

#pragma mark - PhysicsSprite
@implementation PhysicsSprite

-(void) setPhysicsBody:(cpBody *)body
{
	body_ = body;
}

// this method will only get called if the sprite is batched.
// return YES if the physics values (angles, position ) changed
// If you return NO, then nodeToParentTransform won't be called.
-(BOOL) dirty
{
	return YES;
}

// returns the transform matrix according the Chipmunk Body values
-(CGAffineTransform) nodeToParentTransform
{	
	CGFloat x = body_->p.x;
	CGFloat y = body_->p.y;
	
	if ( !isRelativeAnchorPoint_ ) {
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
	
	// Make matrix
	CGFloat c = body_->rot.x;
	CGFloat s = body_->rot.y;
	
	if( ! CGPointEqualToPoint(anchorPointInPoints_, CGPointZero) ){
		x += c*-anchorPointInPoints_.x + -s*-anchorPointInPoints_.y;
		y += s*-anchorPointInPoints_.x + c*-anchorPointInPoints_.y;
	}
	
	// Translate, Rot, anchor Matrix
	transform_ = CGAffineTransformMake( c,  s,
									   -s,	c,
									   x,	y );
	
	return transform_;
}

-(void) dealloc
{
	cpBodyEachShape(body_, removeShape, NULL);
	cpBodyFree( body_ );
	
	[super dealloc];
}

@end

#pragma mark - HelloWorldLayer

@interface HelloWorldLayer ()
-(void) addNewRadDollCharacterAtPosition:(CGPoint)pos;
-(void) createResetButton;
-(void) initPhysics;
@end


@implementation HelloWorldLayer
@synthesize ragDolls;

-(id) init
{
	if( (self=[super init])) {
		
		// enable events
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)
		self.isMouseEnabled = YES;
#endif
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		// title
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Multi touch the screen" fontName:@"Marker Felt" fontSize:36];
		label.position = ccp( s.width / 2, 100);
		[self addChild:label z:-1];
		
		// reset button
		[self createResetButton];
		
		
		// init physics
		[self initPhysics];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ragDoll.plist"];
        CCSpriteBatchNode* ragDollSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"ragDoll.png"  capacity:6];
		[self addChild:ragDollSpriteBatchNode z:0 tag:kTagParentNode];
        
		//[self addNewSpriteAtPosition:ccp(200,200)];
		[self addNewRadDollCharacterAtPosition:ccp(200,200)];
        
		[self scheduleUpdate];
        
        CCSprite* background = [CCSprite spriteWithFile:@"Default.png"];
        background.anchorPoint = ccp(0,0);
        background.opacity = 100;
        [self addChild:background z:-20];
        
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {            
            
            // Really ugly hack to warp a background image to fit the ipad.
            // Should really create a seperate artwork for iPad.
            background.scaleX = 768.0f / 320.0f;
            background.scaleY = 1024.0f / 480.0f;
            
        }
	}
	
	return self;
}

-(void) initPhysics
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	// init chipmunk
	cpInitChipmunk();
	
	space_ = cpSpaceNew();
	
	space_->gravity = ccp(0, -100);
	
	//
	// rogue shapes
	// We have to free them manually
	//
	// bottom
	walls_[0] = cpSegmentShapeNew( space_->staticBody, ccp(0,0), ccp(s.width,0), 0.0f);
	
	// top
	walls_[1] = cpSegmentShapeNew( space_->staticBody, ccp(0,s.height), ccp(s.width,s.height), 0.0f);
	
	// left
	walls_[2] = cpSegmentShapeNew( space_->staticBody, ccp(0,0), ccp(0,s.height), 0.0f);
	
	// right
	walls_[3] = cpSegmentShapeNew( space_->staticBody, ccp(s.width,0), ccp(s.width,s.height), 0.0f);
	
	for( int i=0;i<4;i++) {
		walls_[i]->e = 1.0f;
		walls_[i]->u = 1.0f;
		cpSpaceAddStaticShape(space_, walls_[i] );
	}	
}

- (void)dealloc
{
    // Destroy the array that retained all of the ragdolls.
    self.ragDolls = nil;
    
	// manually Free rogue shapes
	for( int i=0;i<4;i++) {
		cpShapeFree( walls_[i] );
	}
	
	cpSpaceFree( space_ );
	
	[super dealloc];
	
}

-(void) update:(ccTime) delta
{
	// Should use a fixed size step based on the animation interval.
	int steps = 2;
	CGFloat dt = [[CCDirector sharedDirector] animationInterval]/(CGFloat)steps;
    
	for(int i=0; i<steps; i++){
		cpSpaceStep(space_, dt);
	}
    
    for (RagDollCharacter* ragDollCharacter in ragDolls) {
        [ragDollCharacter updateSprites];
    }
}

-(void) createResetButton
{
	CCMenuItemLabel *reset = [CCMenuItemFont itemFromString:@"Reset" block:^(id sender){
		CCScene *s = [CCScene node];
		id child = [HelloWorldLayer node];
		[s addChild:child];
		[[CCDirector sharedDirector] replaceScene: s];
	}];
	
	CCMenu *menu = [CCMenu menuWithItems:reset, nil];
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	menu.position = ccp(s.width/2, 50);
	[self addChild: menu z:-1];	
	
}


-(void) addNewRadDollCharacterAtPosition:(CGPoint)pos
{
	if (ragDolls == nil) {
        self.ragDolls = [NSMutableArray array];
    }
	CCSpriteBatchNode *ragDollSpriteBatchNode = (CCSpriteBatchNode*)[self getChildByTag:kTagParentNode];
	
    RagDollCharacter* aRagDollCharacter = [[[RagDollCharacter alloc] initWithPosition:pos withSpriteBatchNode:ragDollSpriteBatchNode withChipmunkPhysicsSpace:space_] autorelease];
    [ragDolls addObject:aRagDollCharacter];
        
}


#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		[self addNewRadDollCharacterAtPosition:location];
	}
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
#define kFilterFactor 0.05f
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	CGPoint v = ccp( accelX, accelY);
	
	space_->gravity = ccpMult(v, 200);
}

#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)

-(BOOL) ccMouseDown:(NSEvent *)event
{
	CGPoint location = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
	[self addNewSpriteAtPosition:location];
	
	return YES;
}

#endif
@end
