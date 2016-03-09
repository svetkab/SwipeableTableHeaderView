//
//  SwipeableHeaderView.m
//  Created by Svetlana Brodskaya on 10/16/15.
//  Copyright © 2015 Svetlana Brodskaya. All rights reserved.
//

#import "SwipeableHeaderView.h"

#define kButtonSize 120

@implementation SwipeableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHeader:)];
    self.panGestureRecognizer.delegate = self;
    [self.swipebleContainerView addGestureRecognizer:self.panGestureRecognizer];
}

- (void)panHeader:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = [recognizer translationInView:self.swipebleContainerView];
         
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint currentPoint = [recognizer translationInView:self.swipebleContainerView];
            CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
            
            if (deltaX>0) {
                self.buttonLeftWidthLayoutConstraint.constant = deltaX;
                self.buttonRightWidthLayoutConstrain.constant = 0;
            } else {
                self.buttonRightWidthLayoutConstrain.constant = -deltaX;
                self.buttonLeftWidthLayoutConstraint.constant = 0;
            }
      
        }
            break;
        case UIGestureRecognizerStateEnded:{
            
            if (self.buttonLeftWidthLayoutConstraint.constant<kButtonSize*1.2) {
                self.buttonLeftWidthLayoutConstraint.constant=0;
            }else if(self.buttonLeftWidthLayoutConstraint.constant<self.swipebleContainerView.bounds.size.width*0.55){
                self.buttonLeftWidthLayoutConstraint.constant=kButtonSize;
            }else{
                [self buttonPushed:self.buttonLeft];
            }
            
            
            if (self.buttonRightWidthLayoutConstrain.constant<kButtonSize*1.2) {
                self.buttonRightWidthLayoutConstrain.constant=0;
            }else if(self.buttonRightWidthLayoutConstrain.constant<self.swipebleContainerView.bounds.size.width*0.55){
                self.buttonRightWidthLayoutConstrain.constant=kButtonSize;
            }else{
                [self buttonPushed:self.butonRight];
            }

            
            [UIView animateWithDuration:0.33
                             animations:^{
                                 [self layoutIfNeeded];
                             }];
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Pan Cancelled");
            break;
        default:
            break;
    }
}


- (IBAction)buttonPushed:(id)sender {

    if ([sender isEqual:self.buttonLeft]) {
        NSLog(@"buttonLeftPushed");
        [self.delegate playWord:self.headerText.text];
    }
    if ([sender isEqual:self.butonRight]) {
        NSLog(@"buttonRigthPushed");
        [self.delegate deletePlay:self.headerText.text];
    }
    
}
@end

