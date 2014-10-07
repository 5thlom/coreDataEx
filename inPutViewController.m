//
//  inPutViewController.m
//  coreData
//
//  Created by Zhihua Yang on 10/5/14.
//  Copyright (c) 2014 Zhihua Yang. All rights reserved.
//

#import "inPutViewController.h"
#import "AppDelegate.h"

@interface inPutViewController (){
    NSManagedObjectContext *context;
}

@end

@implementation inPutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self firstname] setDelegate:self];
    [self.lastname setDelegate:self];
    AppDelegate *ad = [[UIApplication sharedApplication]delegate];
    context = [ad managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)add:(id)sender {
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    NSManagedObject *newobj = [[NSManagedObject alloc]initWithEntity:des insertIntoManagedObjectContext:context];
    
    [newobj setValue:self.firstname.text forKey:@"firstname"];
    [newobj setValue:self.lastname.text forKey:@"lastname"];
    
    NSError *er;
    [context save:&er];
    
    self.result.text = @"NewData add";
    
    
    
}

- (IBAction)dele:(id)sender {
    
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Person"  inManagedObjectContext:context];
    
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    
    [req setEntity:des];
    
    NSPredicate* pre = [NSPredicate predicateWithFormat:@"firstname like %@ ",self.firstname.text];
    [req setPredicate:pre];
    
    NSError *er;
    
    NSArray *result =[context executeFetchRequest:req error:&er];
    
    if ([result count]<=0) {
        self.result.text = @"Person not found";
    }else{
        NSString *fn;
        NSString *ln;
        NSString *msg=@"Deleted :";
        for (NSManagedObject *oj in result) {
            fn = [oj valueForKey:@"firstname"];
            ln = [oj valueForKey:@"lastname"];
                        msg = [msg stringByAppendingString:[NSString stringWithFormat:@"first name: %@  ,last name: %@",fn,ln]];
            [context deleteObject:oj];

        }
        self.result.text = msg;

    }
    [context save:&er];
    
    
}

- (IBAction)sear:(id)sender {
    NSEntityDescription *des = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    
    [req setEntity:des];
    
    NSPredicate* pre = [NSPredicate predicateWithFormat:@"firstname like %@ and lastname like %@",self.firstname.text,self.lastname.text];
    [req setPredicate:pre];
    
    NSError *er;
    NSArray *result = [context executeFetchRequest:req error:&er];
    if ([result count]<=0) {
        self.result.text = @"Not Record";
    }else{
        NSString *fn;
        NSString *ln;
        for (NSManagedObject *oj in result) {
            fn = [oj valueForKey:@"firstname"];
            ln = [oj valueForKey:@"lastname"];
        }
        self.result.text = [NSString stringWithFormat:@"first name %@, last name %@ ",fn,ln];
    }
}
@end
