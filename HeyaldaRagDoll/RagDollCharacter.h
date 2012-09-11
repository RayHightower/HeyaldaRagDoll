//
//  RagDollCharacter.h
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

#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "cocos2d.h"

@class RagDollSprites;



@interface RagDollCharacter : NSObject {
    

    cpSpace*            physicsSpace; // Weak Reference
    
    RagDollSprites*     ragDollSprites;
    
    // --- Bodies -------
    cpBody*             headBody;
    cpBody*             torsoBody;
    
    cpBody*             upperArmBody1;
    cpBody*             lowerArmBody1;
    cpBody*             upperLegBody1;
    cpBody*             lowerLegBody1;
    
    cpBody*             upperArmBody2;
    cpBody*             lowerArmBody2;
    cpBody*             upperLegBody2;
    cpBody*             lowerLegBody2;


    // --- Shapes ---------
    cpShape*            headShape;
    cpShape*            torsoShape;
    
    cpShape*            upperArmShape1;
    cpShape*            lowerArmShape1;
    cpShape*            upperLegShape1;
    cpShape*            lowerLegShape1;

    cpShape*            upperArmShape2;
    cpShape*            lowerArmShape2;
    cpShape*            upperLegShape2;
    cpShape*            lowerLegShape2;


    
    // --- Constraints -------
    // Head 
    cpConstraint*       headToTorsoPivotJoint;
    cpConstraint*       headRotLimit;
    cpConstraint*       headDampedRotSpringJoint;
       
    // Leg 
    cpConstraint*       torsoToUpperLegPivotJoint1;
    cpConstraint*       upperLegToLowerLegPivotJoint1;

    cpConstraint*       torsoToUpperLegPinJoint2;
    cpConstraint*       upperLegToLowerLegPinJoint2;

    
    // Arm     
    cpConstraint*       upperArmToLowerArmPivotJoint1;
    cpConstraint*       upperArmToTorsoPivotJoint1;

    cpConstraint*       upperArmToLowerArmPinJoint2;
    cpConstraint*       upperArmToTorsoPinJoint2;

    
    // Sholder, hip, elbow, and knee rotary limit joints
    cpConstraint*       sholderRotLimit1;
    cpConstraint*       hipRotLimit1;
    cpConstraint*       elbowRotLimit1;
    cpConstraint*       kneeRotLimit1;

    cpConstraint*       sholderRotLimit2;
    cpConstraint*       hipRotLimit2;
    cpConstraint*       elbowRotLimit2;
    cpConstraint*       kneeRotLimit2;

    
    // --- Parameters to adjust how the ragdoll can move
   
    float               elbowBendMinimumNormal;
    float               elbowBendMaxNormal;
    
    float               kneeBendMinimuNormal;
   
    float               waistBendMinNormal;
    float               waistBendMaxNormal;
    
    float               sholderBendMinNormal;
    float               sholderBendMaxNormal;
    
    float               ragDollElbowMin;
    float               ragDollElbowMax;
    
    float               ragDollKneeMin;
    float               ragDollKneeMax;
    
    float               ragDollWaistMin;
    float               ragDollWaistMax;

}


@property (nonatomic, retain) RagDollSprites*     ragDollSprites;

-(id) initWithPosition:(CGPoint)p withSpriteBatchNode:(CCSpriteBatchNode*)spriteBatchNode withChipmunkPhysicsSpace:(cpSpace*)_physicsSpace;

-(void) updateSprites;

@end
