//
//  JSEImagePicker.m
//  JSExport
//
//  Created by Yaogang Lian on 8/6/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import "JSEImagePicker.h"
#import <MobileCoreServices/UTCoreTypes.h>

@implementation JSEImagePicker

+ (JSEImagePicker *)create
{
    return [[JSEImagePicker alloc] init];
}

+ (BOOL)isSourceTypeAvailable:(NSString *)sourceType
{
    if (![sourceType isEqualToString:@"PhotoLibrary"] && ![sourceType isEqualToString:@"SavedPhotoAlbum"] && ![sourceType isEqualToString:@"Camera"]) {
        return NO;
    }
    
    UIImagePickerControllerSourceType sourceTypeClass = [self getSourceTypeClass:sourceType];
    if (![UIImagePickerController isSourceTypeAvailable:sourceTypeClass]) {
        return NO;
    }
    return YES;
}

+ (UIImagePickerControllerSourceType)getSourceTypeClass:(NSString *) sourceType
{
	if( [sourceType isEqualToString:@"PhotoLibrary"] ) {
		return UIImagePickerControllerSourceTypePhotoLibrary;
	} else if( [sourceType isEqualToString:@"SavedPhotosAlbum"] ) {
		return UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else if( [sourceType isEqualToString:@"Camera"] ) {
		return UIImagePickerControllerSourceTypeCamera;
	}
	return UIImagePickerControllerSourceTypePhotoLibrary;
}

- (void)getPicture:(NSDictionary *)options callback:(JSValue *)cb
{
    callback = cb;
    
    // Get current options
    NSString *sourceType = options[@"sourceType"] ? options[@"sourceType"] : @"PhotoLibrary";
    float popupX = options[@"popupX"] ? [options[@"popupX"] floatValue] : 0.0f;
    float popupY = options[@"popupY"] ? [options[@"popupY"] floatValue] : 0.0f;
    float popupWidth = options[@"popupWidth"] ? [options[@"popupWidth"] floatValue] : 1.0f;
    float popupHeight = options[@"popupHeight"] ? [options[@"popupHeight"] floatValue] : 1.0f;
    
    // Source type validation
    if (![JSEImagePicker isSourceTypeAvailable:sourceType]) {
        [callback callWithArguments:@[@"Error"]];
    }
    
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:_picker];
    _popover.delegate = self;
    
    // Limit to pictures only
    [_picker setMediaTypes:@[(NSString *)kUTTypeImage]];
    [_picker setSourceType:[JSEImagePicker getSourceTypeClass:sourceType]];
    
    [_popover presentPopoverFromRect:CGRectMake(popupX, popupY, popupWidth, popupHeight)
                             inView:[[UIApplication sharedApplication] keyWindow].rootViewController.view permittedArrowDirections:UIPopoverArrowDirectionAny
                           animated:YES];
}

- (void)closePicker
{
    [_picker dismissViewControllerAnimated:YES completion:NULL];
    [_popover dismissPopoverAnimated:YES];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [callback callWithArguments:@[@"Success"]];
    [self closePicker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [callback callWithArguments:@[@"Error"]];
    [self closePicker];
}


#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self closePicker];
}


@end
