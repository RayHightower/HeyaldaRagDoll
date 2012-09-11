//
//  RagDollCharacter.m
//  HeyaldaRagDoll
//
//  Created by Jim Range on 7/16/12.
//  Copyright 2012 Heyalda Corporation. All rights reserved.
//
/*
 
 Copyright 2012 Heyalda Corporation. All rights reserved.
 
 You may use this source code in personal or commercial projects without attribution to the copyright 
 owner of this source code as long as no significant portion of this source code is distributed with
 the work product. 
 
 All digital image media included in this sample project that were created by Heyalda Corporation 
 must not be redistributed in any way; no license to do so is granted.
 
 For example, this source code can be used to create a compiled application that can be sold in the 
 Apple App Store under the condition that none of the digital images created by Heyalda Corporation 
 are included in the application and the application must not include the source code text.
 
 If you publish, distribute, or otherwise make available a significant portion of this source code, 
 you must first receive permission from Heyalda Corporation to do so.
 
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
 DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "RagDollCharacter.h"
#import "RagDollSprites.h"

#define kRagDollCollisionType 1

static NSUInteger ragDollCollisionGroups = 1;


@interface RagDollCharacter (private)
-(void) initRagdollPhysicsWithPosition:(CGPoint)p;
-(void) destroyRagdollPhysicsObjects;
@end

@implementation RagDollCharacter



@synthesize ragDollSprites;

-(id) initWithPosition:(CGPoint)p withSpriteBatchNode:(CCSpriteBatchNode*)spriteBatchNode withChipmunkPhysicsSpace:(cpSpace*)_physicsSpace {
    
    self = [super init];
    if (self){
        
        physicsSpace = _physicsSpace;
        
        self.ragDollSprites = [[[RagDollSprites alloc] initWithSpriteBatchNode:spriteBatchNode] autorelease];
        
        [self initRagdollPhysicsWithPosition:p];
                
        // Each ragdoll gets its own collision group, so
        ++ragDollCollisionGroups;
    }
    
    return self;
    
}


-(void) dealloc {
    
    [self destroyRagdollPhysicsObjects];
    
    self.ragDollSprites = nil;
    
    [super dealloc];
}


-(void) initRagdollPhysicsWithPosition:(CGPoint)p  {
    
    float desiredScale = 0.35;
    
    ragDollSprites.head.scale = desiredScale;

    ragDollSprites.torso.scale = desiredScale;

    ragDollSprites.upperArm1.scale = desiredScale;
    ragDollSprites.lowerArm1.scale = desiredScale;
    ragDollSprites.upperArm2.scale = desiredScale;
    ragDollSprites.lowerArm2.scale = desiredScale;

    ragDollSprites.upperLeg1.scale = desiredScale;
    ragDollSprites.lowerLeg1.scale = desiredScale;
    ragDollSprites.upperLeg2.scale = desiredScale;
    ragDollSprites.lowerLeg2.scale = desiredScale;

    
    // ---------------------------------------------------------
    // Determine the size of the physics bodies and shapes based on the sprite shapes and a desired scale.
    // ---------------------------------------------------------
    CGSize headSize = CGSizeMake( ragDollSprites.head.contentSize.width * desiredScale, ragDollSprites.head.contentSize.height * desiredScale);
    CGSize torsoSize = CGSizeMake( ragDollSprites.torso.contentSize.width * desiredScale, ragDollSprites.torso.contentSize.height * desiredScale);
    
    CGSize upperArmSize = CGSizeMake( ragDollSprites.upperArm1.contentSize.width * desiredScale, ragDollSprites.upperArm1.contentSize.height * desiredScale);
    CGSize lowerArmSize = CGSizeMake( ragDollSprites.lowerArm1.contentSize.width * desiredScale, ragDollSprites.lowerArm1.contentSize.height * desiredScale);
    
    CGSize upperLegSize = CGSizeMake( ragDollSprites.upperLeg1.contentSize.width * desiredScale, ragDollSprites.upperLeg1.contentSize.height * desiredScale);
    CGSize lowerLegSize = CGSizeMake( ragDollSprites.lowerLeg1.contentSize.width * desiredScale, ragDollSprites.lowerLeg1.contentSize.height * desiredScale);

    
    // ---------------------------------------------------------
    // Create the moment of inertia for each physics body.
    // ---------------------------------------------------------
    cpFloat momentHead = cpMomentForBox(5, headSize.width, headSize.height ) ;
    
    cpFloat momentTorso = cpMomentForBox(20, torsoSize.width, torsoSize.height) ;
    
    cpFloat momentUpperArm = cpMomentForBox(15, upperArmSize.width, upperArmSize.height) ;
    cpFloat momentLowerArm = cpMomentForBox(15, lowerArmSize.width, lowerArmSize.height) ;
    
    cpFloat momentUpperLeg = cpMomentForBox(15, upperLegSize.width, upperLegSize.height) ;
    cpFloat momentLowerLeg = cpMomentForBox(15, lowerLegSize.width, lowerLegSize.height) ;

    
    
    // ---------------------------------------------------------
    // Create the bodies
    // ---------------------------------------------------------
    headBody = cpBodyNew(5, momentHead);
    headBody->data = self;
    cpSpaceAddBody(physicsSpace, headBody);
    
    torsoBody = cpBodyNew(20, momentTorso);
    torsoBody->data = self;
    cpSpaceAddBody(physicsSpace, torsoBody);
    
    upperArmBody1 = cpBodyNew(15, momentUpperArm);
    upperArmBody1->data = self;
    cpSpaceAddBody(physicsSpace, upperArmBody1);
    
    lowerArmBody1 = cpBodyNew(15, momentLowerArm);
    lowerArmBody1->data = self;
    cpSpaceAddBody(physicsSpace, lowerArmBody1);
    
    upperLegBody1 = cpBodyNew(15, momentUpperLeg);
    upperLegBody1->data = self;
    cpSpaceAddBody(physicsSpace, upperLegBody1);
    
    lowerLegBody1 = cpBodyNew(15, momentLowerLeg);
    lowerLegBody1->data = self;
    cpSpaceAddBody(physicsSpace, lowerLegBody1);
    
    upperArmBody2 = cpBodyNew(15, momentUpperArm);
    upperArmBody2->data = self;
    cpSpaceAddBody(physicsSpace, upperArmBody2);
    
    lowerArmBody2 = cpBodyNew(15, momentLowerArm);
    lowerArmBody2->data = self;
    cpSpaceAddBody(physicsSpace, lowerArmBody2);
    
    upperLegBody2 = cpBodyNew(15, momentUpperLeg);
    upperLegBody2->data = self;
    cpSpaceAddBody(physicsSpace, upperLegBody2);
    
    lowerLegBody2 = cpBodyNew(15, momentLowerLeg);
    lowerLegBody2->data = self;
    cpSpaceAddBody(physicsSpace, lowerLegBody2);
    
    
    
    // ---------------------------------------------------------
    // Create the shapes and attach them to the bodies
    // ---------------------------------------------------------
    
    // Used to scale the size of the shape relative to the sprite. 
    // Use a value less than on to shrink the size of the physics shape relative to the sprite size.
    float shapeScaleFactor = 0.75;
    
    headShape = cpBoxShapeNew(headBody, headSize.width* shapeScaleFactor, headSize.height * shapeScaleFactor);
    torsoShape = cpBoxShapeNew(torsoBody, torsoSize.width* shapeScaleFactor , torsoSize.height* shapeScaleFactor );
    
    upperArmShape1 = cpBoxShapeNew(upperArmBody1, upperArmSize.width * shapeScaleFactor, upperArmSize.height * shapeScaleFactor);
    lowerArmShape1 = cpBoxShapeNew(lowerArmBody1, lowerArmSize.width * shapeScaleFactor, lowerArmSize.height * shapeScaleFactor);
    
    upperLegShape1 = cpBoxShapeNew(upperLegBody1, upperLegSize.width * shapeScaleFactor, upperLegSize.height * shapeScaleFactor);
    lowerLegShape1 = cpBoxShapeNew(lowerLegBody1, lowerLegSize.width* shapeScaleFactor , lowerLegSize.height * shapeScaleFactor);
    
    
    headShape->e = 1;
    headShape->u = 0.15;
    headShape->collision_type = kRagDollCollisionType;	
    headShape->group = ragDollCollisionGroups;
    headShape->data = nil;
    
    torsoShape->e = 1;
    torsoShape->u = 0.15;
    torsoShape->collision_type = kRagDollCollisionType;	
    torsoShape->group = ragDollCollisionGroups;
    torsoShape->data = nil;
    
    upperArmShape1->e = 1;
    upperArmShape1->u = 0.15;
    upperArmShape1->collision_type = kRagDollCollisionType;	
    upperArmShape1->group = ragDollCollisionGroups;
    upperArmShape1->data = nil;
    
    lowerArmShape1->e = 1;
    lowerArmShape1->u = 0.15;
    lowerArmShape1->collision_type = kRagDollCollisionType;	
    lowerArmShape1->group = ragDollCollisionGroups;
    lowerArmShape1->data = nil;
    
    upperLegShape1->e = 1;
    upperLegShape1->u = 0.15;
    upperLegShape1->collision_type = kRagDollCollisionType;	
    upperLegShape1->group = ragDollCollisionGroups;
    upperLegShape1->data = nil;
    
    lowerLegShape1->e = 1;
    lowerLegShape1->u = 0.15;
    lowerLegShape1->collision_type = kRagDollCollisionType;	
    lowerLegShape1->group = ragDollCollisionGroups;
    lowerLegShape1->data = nil;
    
    
    cpSpaceAddShape(physicsSpace, headShape);
    cpSpaceAddShape(physicsSpace, torsoShape);
    
    cpSpaceAddShape(physicsSpace, upperArmShape1);
    cpSpaceAddShape(physicsSpace, lowerArmShape1);
    
    cpSpaceAddShape(physicsSpace, upperLegShape1);
    cpSpaceAddShape(physicsSpace, lowerLegShape1);
    
    
    upperArmShape2 = cpBoxShapeNew(upperArmBody2, upperArmSize.width * shapeScaleFactor, upperArmSize.height * shapeScaleFactor);
    lowerArmShape2 = cpBoxShapeNew(lowerArmBody2, lowerArmSize.width * shapeScaleFactor, lowerArmSize.height * shapeScaleFactor);
    
    upperLegShape2 = cpBoxShapeNew(upperLegBody2, upperLegSize.width * shapeScaleFactor, upperLegSize.height * shapeScaleFactor);
    lowerLegShape2 = cpBoxShapeNew(lowerLegBody2, lowerLegSize.width * shapeScaleFactor, lowerLegSize.height * shapeScaleFactor);
    
    upperArmShape2->e = 1;
    upperArmShape2->u = 0.15;
    upperArmShape2->collision_type = kRagDollCollisionType;	
    upperArmShape2->group = ragDollCollisionGroups;
    upperArmShape2->data = nil;
    
    lowerArmShape2->e = 1;
    lowerArmShape2->u = 0.15;
    lowerArmShape2->collision_type = kRagDollCollisionType;	
    lowerArmShape2->group = ragDollCollisionGroups;
    lowerArmShape2->data = nil;
    
    upperLegShape2->e = 1;
    upperLegShape2->u = 0.15;
    upperLegShape2->collision_type = kRagDollCollisionType;	
    upperLegShape2->group = ragDollCollisionGroups;
    upperLegShape2->data = nil;
    
    lowerLegShape2->e = 1;
    lowerLegShape2->u = 0.15;
    lowerLegShape2->collision_type = kRagDollCollisionType;	
    lowerLegShape2->group = ragDollCollisionGroups;
    lowerLegShape2->data = nil;
    
    cpSpaceAddShape(physicsSpace, upperArmShape2);
    cpSpaceAddShape(physicsSpace, lowerArmShape2);
    
    cpSpaceAddShape(physicsSpace, upperLegShape2);
    cpSpaceAddShape(physicsSpace, lowerLegShape2);
    

    
    // ---------------------------------------------------------------
    // Connect the bodies together with pin joints.
    // ---------------------------------------------------------------
    
    
    CGPoint torsoAnchorForhead = cpv(0, torsoSize.height * 0.65 * 0.85);
    CGPoint headAnchorForTorso = cpv(-headSize.width * 0.1, -headSize.height * 0.15);
    headToTorsoPivotJoint = cpPivotJointNew2(torsoBody, headBody, torsoAnchorForhead, headAnchorForTorso);
    cpSpaceAddConstraint(physicsSpace, headToTorsoPivotJoint);
    
    
    CGPoint torsoAnchorForUppperArm = cpv(0, torsoSize.height * 0.5 * 0.85);
    CGPoint uppperArmAnchorForTorso = cpv(0, upperArmSize.height * 0.5 * 0.95);
    upperArmToTorsoPivotJoint1 = cpPivotJointNew2(torsoBody, upperArmBody1, torsoAnchorForUppperArm, uppperArmAnchorForTorso);
    cpSpaceAddConstraint(physicsSpace, upperArmToTorsoPivotJoint1);
    
    CGPoint torsoAnchorForUppperLeg = cpv(-torsoSize.width * 0.2, -torsoSize.height * 0.5 * 0.85);
    CGPoint uppperLegAnchorForTorso = cpv(0, upperLegSize.height * 0.5 * 0.95);
    torsoToUpperLegPivotJoint1 = cpPivotJointNew2(torsoBody, upperLegBody1, torsoAnchorForUppperLeg, uppperLegAnchorForTorso);
    cpSpaceAddConstraint(physicsSpace, torsoToUpperLegPivotJoint1);
    
    CGPoint lowerArmAnchorForUpperArm = cpv(0, lowerArmSize.height * 0.5 * 0.95);
    CGPoint uppperArmAnchorForLowerArm = cpv(0, -upperArmSize.height * 0.5 * 0.95);
    upperArmToLowerArmPivotJoint1 = cpPivotJointNew2(upperArmBody1, lowerArmBody1, uppperArmAnchorForLowerArm, lowerArmAnchorForUpperArm);
    cpSpaceAddConstraint(physicsSpace, upperArmToLowerArmPivotJoint1);
    
    CGPoint lowerLegAnchorForupperLeg = cpv(lowerLegSize.width * 0.1, lowerLegSize.height * 0.5 * 0.95);
    CGPoint uppperLegAnchorForLowerLeg = cpv(0, -upperLegSize.height * 0.5 * 0.85);
    upperLegToLowerLegPivotJoint1 = cpPivotJointNew2(upperLegBody1, lowerLegBody1, uppperLegAnchorForLowerLeg, lowerLegAnchorForupperLeg);
    cpSpaceAddConstraint(physicsSpace, upperLegToLowerLegPivotJoint1);
    


    upperArmToTorsoPinJoint2 = cpPivotJointNew2(torsoBody, upperArmBody2, torsoAnchorForUppperArm, uppperArmAnchorForTorso);
    cpSpaceAddConstraint(physicsSpace, upperArmToTorsoPinJoint2);
    
    torsoToUpperLegPinJoint2 = cpPivotJointNew2(torsoBody, upperLegBody2, torsoAnchorForUppperLeg, uppperLegAnchorForTorso);
    cpSpaceAddConstraint(physicsSpace, torsoToUpperLegPinJoint2);
    
    upperArmToLowerArmPinJoint2 = cpPivotJointNew2(upperArmBody2, lowerArmBody2, uppperArmAnchorForLowerArm, lowerArmAnchorForUpperArm);
    cpSpaceAddConstraint(physicsSpace, upperArmToLowerArmPinJoint2);
    
    upperLegToLowerLegPinJoint2 = cpPivotJointNew2(upperLegBody2, lowerLegBody2, uppperLegAnchorForLowerLeg, lowerLegAnchorForupperLeg);
    cpSpaceAddConstraint(physicsSpace, upperLegToLowerLegPinJoint2);

    
    
    // ---------------------------------------------------------------
    // Set the rough position of the parts
    // ---------------------------------------------------------------

    headBody->p = ccp(p.x, p.y + torsoSize.height * 0.5);
    torsoBody->p = p;
    
    upperArmBody1->p = ccp(p.x, p.y + torsoSize.height * 0.5);;
    lowerArmBody1->p = ccp(p.x, p.y + torsoSize.height * 0.25);;
    upperLegBody1->p = ccp(p.x, p.y - torsoSize.height * 0.5);;
    lowerLegBody1->p = ccp(p.x, p.y - torsoSize.height );;
    
    upperArmBody2->p = upperArmBody1->p;
    lowerArmBody2->p = lowerArmBody1->p;
    upperLegBody2->p = upperLegBody1->p;
    lowerLegBody2->p = lowerLegBody1->p;
    

    
    // ----------------------------------------------------------------
    // Add the rotary limit joints
    // ----------------------------------------------------------------
    
    // Elbow
    elbowBendMinimumNormal = M_PI_4;
    kneeBendMinimuNormal = -M_PI_4;
    
    elbowBendMaxNormal = M_PI_2;
    
    elbowRotLimit1 = cpRotaryLimitJointNew(upperArmBody1, lowerArmBody1, elbowBendMinimumNormal,  elbowBendMaxNormal);
    cpSpaceAddConstraint(physicsSpace, elbowRotLimit1);
    
    elbowRotLimit2 = cpRotaryLimitJointNew(upperArmBody2, lowerArmBody2, elbowBendMinimumNormal,  elbowBendMaxNormal);
    cpSpaceAddConstraint(physicsSpace, elbowRotLimit2);
    
    
    // Knee
    kneeRotLimit1 = cpRotaryLimitJointNew(upperLegBody1, lowerLegBody1, kneeBendMinimuNormal , 0);
    cpSpaceAddConstraint(physicsSpace, kneeRotLimit1);
    
    kneeRotLimit2 = cpRotaryLimitJointNew(upperLegBody2, lowerLegBody2, kneeBendMinimuNormal , 0);
    cpSpaceAddConstraint(physicsSpace, kneeRotLimit2);
    
    
    // Hip
    waistBendMinNormal = 0;
    waistBendMaxNormal = M_PI_2;
    
    hipRotLimit1 = cpRotaryLimitJointNew(torsoBody, upperLegBody1, waistBendMinNormal,  waistBendMaxNormal);
    cpSpaceAddConstraint(physicsSpace, hipRotLimit1);
    
    hipRotLimit2 = cpRotaryLimitJointNew(torsoBody, upperLegBody2, waistBendMinNormal,  waistBendMaxNormal);
    cpSpaceAddConstraint(physicsSpace, hipRotLimit2);
    
    
    // Sholder
    
    sholderBendMinNormal = 0;
    sholderBendMaxNormal = M_PI_2;
    
    sholderRotLimit1 = cpRotaryLimitJointNew(torsoBody, upperArmBody1, sholderBendMinNormal,  sholderBendMaxNormal);
    cpSpaceAddConstraint(physicsSpace, sholderRotLimit1);
    
    sholderRotLimit2 = cpRotaryLimitJointNew(torsoBody, upperArmBody2, sholderBendMinNormal,  sholderBendMaxNormal);
    cpSpaceAddConstraint(physicsSpace, sholderRotLimit2);
    
    
    
    // Head
    headRotLimit = cpRotaryLimitJointNew(torsoBody, headBody,  M_PI_4 * 0.5 , M_PI_4);
    cpSpaceAddConstraint(physicsSpace, headRotLimit);
    
    headDampedRotSpringJoint = cpDampedRotarySpringNew(headBody, torsoBody, 0, 1000000, 1000);
    cpSpaceAddConstraint(physicsSpace, headDampedRotSpringJoint);
    
    

    
}


-(void) destroyRagdollPhysicsObjects {
    
    
    // ------------------------------------------
    // Remove and free all of the constraints.
    // ------------------------------------------

    cpSpaceRemoveConstraint(physicsSpace, headToTorsoPivotJoint);
    cpConstraintFree(headToTorsoPivotJoint);
    
    cpSpaceRemoveConstraint(physicsSpace, upperLegToLowerLegPivotJoint1);
    cpConstraintFree(upperLegToLowerLegPivotJoint1);
    
    cpSpaceRemoveConstraint(physicsSpace, torsoToUpperLegPivotJoint1);
    cpConstraintFree(torsoToUpperLegPivotJoint1);
    
    
    cpSpaceRemoveConstraint(physicsSpace, upperArmToLowerArmPivotJoint1);
    cpConstraintFree(upperArmToLowerArmPivotJoint1);
    
    cpSpaceRemoveConstraint(physicsSpace, upperArmToTorsoPivotJoint1);
    cpConstraintFree(upperArmToTorsoPivotJoint1);
    
    cpSpaceRemoveConstraint(physicsSpace, headDampedRotSpringJoint);
    cpConstraintFree(headDampedRotSpringJoint);
    
    cpSpaceRemoveConstraint(physicsSpace, kneeRotLimit1);
    cpConstraintFree(kneeRotLimit1);
    
    cpSpaceRemoveConstraint(physicsSpace, hipRotLimit1);
    cpConstraintFree(hipRotLimit1);
    
    cpSpaceRemoveConstraint(physicsSpace, elbowRotLimit1);
    cpConstraintFree(elbowRotLimit1);
    
    cpSpaceRemoveConstraint(physicsSpace, sholderRotLimit1);
    cpConstraintFree(sholderRotLimit1);
    
    cpSpaceRemoveConstraint(physicsSpace, headRotLimit);
    cpConstraintFree(headRotLimit);
    
    cpSpaceRemoveConstraint(physicsSpace, upperArmToLowerArmPinJoint2);
    cpConstraintFree(upperArmToLowerArmPinJoint2);
    
    cpSpaceRemoveConstraint(physicsSpace, upperArmToTorsoPinJoint2);
    cpConstraintFree(upperArmToTorsoPinJoint2);
    
    cpSpaceRemoveConstraint(physicsSpace, torsoToUpperLegPinJoint2);
    cpConstraintFree(torsoToUpperLegPinJoint2);
    
    cpSpaceRemoveConstraint(physicsSpace, upperLegToLowerLegPinJoint2);
    cpConstraintFree(upperLegToLowerLegPinJoint2);
    
    cpSpaceRemoveConstraint(physicsSpace, sholderRotLimit2);
    cpConstraintFree(sholderRotLimit2);
    
    cpSpaceRemoveConstraint(physicsSpace, hipRotLimit2);
    cpConstraintFree(hipRotLimit2);
    
    cpSpaceRemoveConstraint(physicsSpace, elbowRotLimit2);
    cpConstraintFree(elbowRotLimit2);
    
    cpSpaceRemoveConstraint(physicsSpace, kneeRotLimit2);
    cpConstraintFree(kneeRotLimit2);
    
    
    
    // ------------------------------------------
    // Remove and free all of the shapes
    // ------------------------------------------
    
    cpSpaceRemoveShape(physicsSpace, headShape); 
    cpShapeFree(headShape);
    
    cpSpaceRemoveShape(physicsSpace, torsoShape); 
    cpShapeFree(torsoShape);
    
    cpSpaceRemoveShape(physicsSpace, upperArmShape1); 
    cpShapeFree(upperArmShape1);
    
    cpSpaceRemoveShape(physicsSpace, lowerArmShape1); 
    cpShapeFree(lowerArmShape1);
    
    cpSpaceRemoveShape(physicsSpace, upperLegShape1); 
    cpShapeFree(upperLegShape1);
    
    cpSpaceRemoveShape(physicsSpace, lowerLegShape1); 
    cpShapeFree(lowerLegShape1);
    
    cpSpaceRemoveShape(physicsSpace, upperArmShape2); 
    cpShapeFree(upperArmShape2);
    
    cpSpaceRemoveShape(physicsSpace, lowerArmShape2); 
    cpShapeFree(lowerArmShape2);
    
    cpSpaceRemoveShape(physicsSpace, upperLegShape2); 
    cpShapeFree(upperLegShape2);
    
    cpSpaceRemoveShape(physicsSpace, lowerLegShape2); 
    cpShapeFree(lowerLegShape2);
    
    
    
    // ------------------------------------------
    // Remove and free all of the bodies
    // ------------------------------------------
    
    cpSpaceRemoveBody(physicsSpace, headBody);
    cpBodyFree(headBody);
    
    cpSpaceRemoveBody(physicsSpace, torsoBody);
    cpBodyFree(torsoBody);
    
    cpSpaceRemoveBody(physicsSpace, upperArmBody1);
    cpBodyFree(upperArmBody1);
    
    cpSpaceRemoveBody(physicsSpace, lowerArmBody1);
    cpBodyFree(lowerArmBody1);
    
    cpSpaceRemoveBody(physicsSpace, upperLegBody1);
    cpBodyFree(upperLegBody1);
    
    cpSpaceRemoveBody(physicsSpace, lowerLegBody1);
    cpBodyFree(lowerLegBody1);
    
    cpSpaceRemoveBody(physicsSpace, upperArmBody2);
    cpBodyFree(upperArmBody2);
    
    cpSpaceRemoveBody(physicsSpace, lowerArmBody2);
    cpBodyFree(lowerArmBody2);
    
    cpSpaceRemoveBody(physicsSpace, upperLegBody2);
    cpBodyFree(upperLegBody2);
    
    cpSpaceRemoveBody(physicsSpace, lowerLegBody2);
    cpBodyFree(lowerLegBody2);
    
}


-(void) updateSprites {
        
    // Update the position and rotation of each sprite based on the position and rotaiton of the physics bodies.
    
    ragDollSprites.head.position = headBody->p;
    ragDollSprites.head.rotation = -CC_RADIANS_TO_DEGREES(headBody->a);

    
    ragDollSprites.torso.position = torsoBody->p;
    ragDollSprites.torso.rotation = -CC_RADIANS_TO_DEGREES(torsoBody->a);

    
    ragDollSprites.upperArm1.position = upperArmBody1->p;
    ragDollSprites.upperArm1.rotation = -CC_RADIANS_TO_DEGREES(upperArmBody1->a);

    ragDollSprites.lowerArm1.position = lowerArmBody1->p;
    ragDollSprites.lowerArm1.rotation = -CC_RADIANS_TO_DEGREES(lowerArmBody1->a);

    ragDollSprites.upperLeg1.position = upperLegBody1->p;
    ragDollSprites.upperLeg1.rotation = -CC_RADIANS_TO_DEGREES(upperLegBody1->a);
    
    ragDollSprites.lowerLeg1.position = lowerLegBody1->p;
    ragDollSprites.lowerLeg1.rotation = -CC_RADIANS_TO_DEGREES(lowerLegBody1->a);

    
    ragDollSprites.upperArm2.position = upperArmBody2->p;
    ragDollSprites.upperArm2.rotation = -CC_RADIANS_TO_DEGREES(upperArmBody2->a);
    
    ragDollSprites.lowerArm2.position = lowerArmBody2->p;
    ragDollSprites.lowerArm2.rotation = -CC_RADIANS_TO_DEGREES(lowerArmBody2->a);
    
    ragDollSprites.upperLeg2.position = upperLegBody2->p;
    ragDollSprites.upperLeg2.rotation = -CC_RADIANS_TO_DEGREES(upperLegBody2->a);
    
    ragDollSprites.lowerLeg2.position = lowerLegBody2->p;
    ragDollSprites.lowerLeg2.rotation = -CC_RADIANS_TO_DEGREES(lowerLegBody2->a);

    
    
}

@end
