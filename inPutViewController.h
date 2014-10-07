//
//  inPutViewController.h
//  coreData
//
//  Created by Zhihua Yang on 10/5/14.
//  Copyright (c) 2014 Zhihua Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inPutViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UILabel *result;
- (IBAction)add:(id)sender;
- (IBAction)dele:(id)sender;
- (IBAction)sear:(id)sender;

@end
