//
//  FurnitureTableViewController.m
//  IntroToRealm2
//
//  Created by Benson Huynh on 2016-02-05.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "FurnitureTableViewController.h"
#import "Room.h"
#import "Furniture.h"

@interface FurnitureTableViewController ()

@end

@implementation FurnitureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.tableView reloadData];
}

- (void)insertNewObject:(id)sender {
UIAlertController *alertController = [UIAlertController
                                      alertControllerWithTitle:@"Add New Furniture To Room"
                                      message:@"Enter Furniture Name:"
                                      preferredStyle:UIAlertControllerStyleAlert];

[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
 {
     textField.placeholder = @"Furiture Name";
 }];

UIAlertAction *cancelAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"Cancel action");
                               }];

UIAlertAction *okAction = [UIAlertAction
                           actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action)
                           {
                               NSLog(@"OK action");
                               Furniture *newFurniture = [[Furniture alloc] init];
                               newFurniture.name = alertController.textFields[0].text;
                               newFurniture.room = self.room;
                               RLMRealm *realm = [RLMRealm defaultRealm];
                               
                               [realm beginWriteTransaction];
                               [realm addObject:newFurniture];
                               [self.room.furniture addObject:newFurniture];
                               [realm commitWriteTransaction];
                               [self.tableView reloadData];
                           }];

[alertController addAction:okAction];
[alertController addAction:cancelAction];

[self presentViewController:alertController animated:true completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.room.furniture.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellFurniture" forIndexPath:indexPath];
    Furniture *furniture = self.room.furniture[indexPath.row];
    cell.textLabel.text = furniture.name;
    return cell;
}

@end
