//
//  SwipeableHeaderView.h
//  Created by Svetlana Brodskaya on 10/16/15.
//  Copyright © 2015 Svetlana Brodskaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WordReviewDelegate;

@interface SwipeableHeaderView : UIView<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIButton *butonRight;
@property (weak, nonatomic) IBOutlet UILabel *headerText;
@property (weak, nonatomic) IBOutlet UIView *swipebleContainerView;

@property (nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLeftWidthLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonRightWidthLayoutConstrain;

@property (nonatomic, assign) CGPoint panStartPoint;

@property (nonatomic, weak) id<WordReviewDelegate> delegate;

- (IBAction)buttonPushed:(id)sender;

@end

@protocol WordReviewDelegate <NSObject>

- (void)playWord:(NSString*)word;

- (void)deletePlay:(NSString*)word;

@end

