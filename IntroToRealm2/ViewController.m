//
//  ViewController.m
//  IntroToRealm2
//
//  Created by Benson Huynh on 2016-02-05.
//  Copyright © 2016 Benson Huynh. All rights reserved.
//

#import "ViewController.h"
#import "Room.h"
#import "FurnitureTableViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *rooms;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (IBAction)addRoomPressed:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Create New Room"
                                          message:@"Enter Room Name:"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"Room Name";
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
                                   Room *newRoom = [[Room alloc] init];
                                   newRoom.name = alertController.textFields[0].text;
                                   RLMRealm *realm = [RLMRealm defaultRealm];
                                   [realm beginWriteTransaction];
                                   [realm addObject:newRoom];
                                   [realm commitWriteTransaction];
                                   [self.tableView reloadData];
                               }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)insertNewObject:(id)sender {
    if (!self.rooms) {
        self.rooms = [[NSMutableArray alloc] init];
    }
    [self.rooms insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RLMResults<Room *> *rooms = [Room allObjects];
    return [rooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    RLMResults<Room *> *rooms = [Room allObjects];
    Room *roomAtCell = rooms[indexPath.row];
    cell.textLabel.text = roomAtCell.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.rooms removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FurnitureTableViewController *controller = (FurnitureTableViewController *)[segue destinationViewController];
        RLMResults<Room *> *rooms = [Room allObjects];
        Room *roomAtCell = rooms[indexPath.row];
        
        controller.room = roomAtCell;
    }
}

@end
