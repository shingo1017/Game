//
//  UIView+Extend.m
//  library
//
//  Created by Shingo on 13-8-2.
//  Copyright (c) 2013年 Shingo. All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView(Extend)

+ (UIView *)viewWithName:(NSString *)name {
    
    NSArray *s = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
    
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] objectAtIndex:0];
}

+ (UIView *)lineWithFrame:(CGRect)frame {
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = WHITE_COLOR;
    return line;
}

- (void)sizeToFitAndSetPoint:(CGPoint)point {
    
    [self sizeToFit];
    
    self.frame = CGRectMake(point.x, point.y, self.width, self.height);
}

- (UIViewController *) viewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

- (void)clearBorderStyle {
    
    self.layer.borderWidth = 0;
    self.layer.masksToBounds = YES;
}

- (void)searchContainerStyle {
    
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)lightBorderStyle {
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGBA(240, 240, 240, 1).CGColor;
    self.layer.masksToBounds = YES;
}

- (void)borderStyle {
    
    [self borderStyleWithColor:WHITE_COLOR];
}

- (void)borderStyleWithColor:(UIColor *)color {
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
}

- (void)heavyborderStyle {
    
    self.layer.borderWidth = 2;
    self.layer.borderColor = RGBA(200, 200, 200, 1).CGColor;
    self.layer.masksToBounds = YES;
}

- (void)cornerRadiusStyle {
    
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = YES;
}

- (void)cornerRadiusStyleWithValue:(CGFloat)value {
    
    self.layer.cornerRadius = value;
    self.layer.masksToBounds = YES;
}

- (void)roundStyle {
    
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
}

- (void)roundWidthStyle {
    
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
}

- (void)roundHeightStyle {
    
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
}

- (UIColor *)colorAtPosition:(CGPoint)position {
    
    CGPoint p = CGPointMake(position.x / self.frame.size.width, position.y / self.frame.size.height);
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef cgImage = [image CGImage];
    CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
    CFDataRef bitmapData = CGDataProviderCopyData(provider);
    const UInt8* data = CFDataGetBytePtr(bitmapData);
    size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    int col = p.x*(width-1);
    int row = p.y*(height-1);
    const UInt8* pixel = data + row*bytesPerRow+col*4;
    UIColor* returnColor = [UIColor colorWithRed:pixel[2]/255. green:pixel[1]/255. blue:pixel[0]/255. alpha:1.0];
    CFRelease(bitmapData);
    return returnColor;
}

- (CGSize)fitSize {
    
    CGRect rect = self.frame;
    [self sizeToFit];
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    return size;
}

// Retrieve and set the origin
- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

@end
