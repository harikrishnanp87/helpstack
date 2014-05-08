//
//  HelpStackAppearance.m
//  HelpApp
//
//  Created by Santhana Amuthan on 16/11/13.
//  Copyright (c) 2013 Anand. All rights reserved.
//

#import "HSAppearance.h"
#import "HSGear.h"
#import "HSHelpStack.h"
#import "UIColor+Extended.h"

#pragma mark - Default UI properties

/* BackgroundColor */
#define DEFAULT_BACKGROUNDCOLOR [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]
#define DEFAULT_CHATBUBBLE_BORDERCOLOR [UIColor grayColor]
#define DEFAULT_RIGHTCHATBUBBLE_COLOR [UIColor colorWithRed:129.0/255.0 green:197.0/255.0 blue:123.0/255.0 alpha:1.0]
#define DEFAULT_LEFTCHATBUBBLE_COLOR [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]

/* Navigation Bar Properties */
#define DEFAULT_NAVIGATIONBAR_BACKGROUNDCOLOR [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]
#define DEFAULT_NAVIGATIONBAR_TITLEFONT [UIFont systemFontOfSize:15.0]
#define DEFAULT_NAVIGATIONBAR_TITLECOLOR [UIColor blackColor]
#define DEFAULT_NAVIGATIONBAR_BUTTONTINTCOLOR [UIColor colorWithRed:49.0/255.0 green:144.0/255.0 blue:213.0/255.0 alpha:1.0]

/* TableView Properties */
#define DEFAULT_TABLEVIEW_BACKGROUNDCOLOR [UIColor colorWithRed:129.0/255.0 green:197.0/255.0 blue:123.0/255.0 alpha:1.0]
#define DEFAULT_TABLEVIEW_SEPARATORCOLOR [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0]
#define DEFAULT_HEADER_BACKGROUNDCOLOR [UIColor colorWithRed:129.0/255.0 green:197.0/255.0 blue:123.0/255.0 alpha:1.0]
#define DEFAULT_HEADER_TITLEFONT [UIFont boldSystemFontOfSize:12.0]
#define DEFAULT_HEADER_TITLECOLOR [UIColor whiteColor]
#define DEFAULT_CELL_BACKGROUNDCOLOR [UIColor whiteColor]

/* Label Properties */
#define DEFAULT_LABEL_BACKGROUNDCOLOR [UIColor clearColor]
#define DEFAULT_LABEL_FONT [UIFont systemFontOfSize:14.0]
#define DEFAULT_LABEL_COLOR [UIColor blackColor]

/* Button Properties */
#define DEFAULT_BUTTON_BACKGROUNDCOLOR [UIColor clearColor]
#define DEFAULT_BUTTON_TITLECOLOR [UIColor whiteColor]
#define DEFAULT_BUTTON_TITLEFONT [UIFont systemFontOfSize:12.0]

/* TextView Attributes */
#define DEFAULT_TEXTVIEW_BACKGROUNDCOLOR [UIColor whiteColor]
#define DEFAULT_TEXTVIEW_TEXTCOLOR [UIColor blackColor]
#define DEFAULT_TEXTVIEW_FONT [UIFont systemFontOfSize:15.0]

/* TextField Attributes */
#define DEFAULT_TEXTFIELD_BACKGROUNDCOLOR [UIColor clearColor]
#define DEFAULT_TEXTFIELD_TEXTCOLOR [UIColor blackColor]
#define DEFAULT_TEXTFIELD_FONT [UIFont systemFontOfSize:15.0]

@interface HSAppearance()

/**NavigationBar Properties */
@property (nonatomic, strong) UIColor *navBarBgColor;
@property (nonatomic, strong) NSString *navBarImageName;
@property (nonatomic, strong) UIColor *navBarTitleColor;
@property (nonatomic, strong) UIFont *navBarTitleFont;
@property (nonatomic, strong) UIColor *navBarTintColor;

/** Header Properties */
@property (nonatomic, strong) UIColor *headerBgColor;
@property (nonatomic, strong) UIFont *headerTitleFont;
@property (nonatomic, strong) UIColor *headerTitleColor;

/** Cell Properties */
@property (nonatomic, strong) UIColor *cellBgColor;

/** Label Properties */
@property (nonatomic, strong) UIColor *labelBgColor;
@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic, strong) UIColor *labelColor;

/** Chat Bubble Properties */
@property (nonatomic, strong) UIColor *leftChatBubble_BackgroundColor;
@property (nonatomic, strong) UIColor *leftChatBubble_textColor;
@property (nonatomic, strong) UIFont *leftChatBubble_textFont;
@property (nonatomic, strong) UIColor *rightChatBubble_BackgroundColor;
@property (nonatomic, strong) UIColor *rightChatBubble_textColor;
@property (nonatomic, strong) UIFont *rightChatBubble_textFont;
@property (nonatomic, strong) UIColor *messageInfoTextColor;
@property (nonatomic, strong) UIFont *messageInfoTextFont;

@end

@implementation HSAppearance

+ (id)instance {

    static HSAppearance* sharedAppearance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppearance = [[HSAppearance alloc] init];
        [sharedAppearance refreshAppearanceProperties]; //defaults get set.

    });

    return sharedAppearance;
}

- (void)setCustomThemeProperties:(NSDictionary *)customThemeProperties {
    
    _customThemeProperties = customThemeProperties;
    [self refreshAppearanceProperties]; //if theme exist, those colors or fonts get set.
}

- (void)refreshAppearanceProperties {
    
    [self getNavigationBarProperties];
    [self getTableViewCellProperties];
    [self getTableHeaderProperties];
    [self getLabelProperties];
    [self getBackgroundColor];
    [self getChatBubbleProperties];
}

- (void)getNavigationBarProperties {

    self.navBarBgColor = DEFAULT_NAVIGATIONBAR_BACKGROUNDCOLOR;
    self.navBarTitleFont = DEFAULT_NAVIGATIONBAR_TITLEFONT;
    self.navBarTitleColor = DEFAULT_NAVIGATIONBAR_TITLECOLOR;
    self.navBarTintColor = DEFAULT_NAVIGATIONBAR_BUTTONTINTCOLOR;
    self.navBarImageName = nil;
    
    NSDictionary *navBarDict = [self.customThemeProperties objectForKey:@"NavigationBar"];
    
    //NavigationBar background Color
    NSString *colorString = [navBarDict objectForKey:@"BackgroundColor"];
    if(colorString != nil){
        UIColor *bgColor = [UIColor colorFromRGBString:colorString];
        if(bgColor != nil){
            self.navBarBgColor = bgColor;
        }
    }
    
    self.navBarImageName = [navBarDict objectForKey:@"BackgroundImage"];
    
    //NavigationBar Title
    NSString *titleFontName = [navBarDict objectForKey:@"TitleFont"];
    NSString *titleFontSize = [navBarDict objectForKey:@"TitleFontSize"];
    float titlesize = [titleFontSize floatValue];
    UIFont *titleFont = [UIFont fontWithName:titleFontName size:titlesize];
    if(titleFont != nil){
        self.navBarTitleFont = titleFont;
    }
    NSString *titlecolorString = [navBarDict objectForKey:@"TitleFontColor"];
    if(titlecolorString != nil){
        UIColor *titleColor = [UIColor colorFromRGBString:titlecolorString];
        if(titleColor != nil){
            self.navBarTitleColor = titleColor;
        }
    }
    
    //NavigationBar Tint Color
    NSString *tintColorString = [navBarDict objectForKey:@"ButtonTintColor"];
    if(tintColorString != nil){
        UIColor *tintColor = [UIColor colorFromRGBString:tintColorString];
        if(tintColor != nil){
            self.navBarTintColor = tintColor;
        }
    }
}

- (void)getTableViewCellProperties {
    
    self.cellBgColor = DEFAULT_CELL_BACKGROUNDCOLOR;

    //Background Color
    NSDictionary *tableViewDict = [self.customThemeProperties objectForKey:@"TableView"];
    NSString *bgColorString = [tableViewDict objectForKey:@"CellBackgroundColor"];
    if(bgColorString != nil){
        UIColor *bgColor = [UIColor colorFromRGBString:bgColorString];
        if(bgColor != nil){
            self.cellBgColor = bgColor;
        }
    }
}

- (void)getTableHeaderProperties {
    
    self.headerBgColor = DEFAULT_HEADER_BACKGROUNDCOLOR;
    self.headerTitleColor = DEFAULT_HEADER_TITLECOLOR;
    self.headerTitleFont = DEFAULT_HEADER_TITLEFONT;

    //Background Color
    NSDictionary *tableViewDict = [self.customThemeProperties objectForKey:@"TableView"];
    NSString *bgColorString = [tableViewDict objectForKey:@"HeaderBackgroundColor"];
    if(bgColorString != nil){
        UIColor *bgColor = [UIColor colorFromRGBString:bgColorString];
        if(bgColor != nil){
            self.headerBgColor = bgColor;
        }
    }

    //Title Font
    NSString *titleFontString = [tableViewDict objectForKey:@"HeadingFont"];
    NSString *titleFontSize = [tableViewDict objectForKey:@"HeadingSize"];
    if(titleFontSize && titleFontString){
        UIFont *customFont = [UIFont fontWithName:titleFontString size:[titleFontSize floatValue]];
        if(customFont != nil){
            self.headerTitleFont = customFont;
        }
    }
    
    //Title Color
    NSString *titleColorString = [tableViewDict objectForKey:@"HeadingColor"];
    if(titleColorString != nil){
        UIColor *customColor = [UIColor colorFromRGBString:titleColorString];
        if(customColor != nil){
            self.headerTitleColor = customColor;
        }
    }
}

- (void)getLabelProperties {
    
    self.labelBgColor = DEFAULT_LABEL_BACKGROUNDCOLOR;
    self.labelColor = DEFAULT_LABEL_COLOR;
    self.labelFont = DEFAULT_LABEL_FONT;
    
    NSDictionary *textDict = [self.customThemeProperties objectForKey:@"LabelAttributes"];
    
    //BackgroundColor
    NSString *bgColorString = [textDict objectForKey:@"BackgroundColor"];
    if(bgColorString != nil){
        UIColor *custombgColor = [UIColor colorFromRGBString:bgColorString];
        if(custombgColor != nil){
            self.labelBgColor = custombgColor;
        }
    }
    
    //Label Color
    NSString *titleColorString = [textDict objectForKey:@"LabelColor"];
    if(titleColorString != nil){
        UIColor *customlabelColor = [UIColor colorFromRGBString:titleColorString];
        if(customlabelColor != nil){
            self.labelColor = customlabelColor;
        }
    }
    
    //Label Font
    NSString *titleFontString = [textDict objectForKey:@"LabelFont"];
    NSString *titleFontSize = [textDict objectForKey:@"LabelSize"];
    if(titleFontString && titleFontSize){
        UIFont *customFont = [UIFont fontWithName:titleFontString size:[titleFontSize floatValue]];
        if(customFont != nil){
            self.labelFont = customFont;
        }
    }
}

-(void)getChatBubbleProperties {
    
    self.rightChatBubble_BackgroundColor = self.headerBgColor;
    self.rightChatBubble_textColor = self.labelColor;
    self.rightChatBubble_textFont = self.labelFont;
    
    self.leftChatBubble_BackgroundColor = self.cellBgColor;
    self.leftChatBubble_textColor = self.labelColor;
    self.leftChatBubble_textFont = self.labelFont;
    
    self.messageInfoTextColor = self.labelColor;
    self.messageInfoTextFont = self.labelFont;
    
    NSDictionary *rightChatBubbleProperties = [self.customThemeProperties objectForKey:@"RightChatBubbleAttributes"];
    NSDictionary *leftChatBubbleProperties = [self.customThemeProperties objectForKey:@"LeftChatBubbleAttributes"];
    
    if(rightChatBubbleProperties) {
        NSString *bgColorString = [rightChatBubbleProperties objectForKey:@"BackgroundColor"];
        if(bgColorString){
            UIColor *bgColor = [UIColor colorFromRGBString:bgColorString];
            if(bgColor){
                self.rightChatBubble_BackgroundColor = bgColor;
            }
        }
        
        NSString *textColorString = [rightChatBubbleProperties objectForKey:@"TextColor"];
        if(textColorString){
            UIColor *textColor = [UIColor colorFromRGBString:textColorString];
            if(textColor){
                self.rightChatBubble_textColor = textColor;
            }
        }
        
        NSString *textFontString = [rightChatBubbleProperties objectForKey:@"TextFont"];
        NSString *textFontSize = [rightChatBubbleProperties objectForKey:@"TextSize"];
        if(textFontString && textFontSize && textFontString.length > 0 && textFontSize.length > 0){
            UIFont *customFont = [UIFont fontWithName:textFontString size:[textFontSize floatValue]];
            if(customFont != nil){
                self.rightChatBubble_textFont = customFont;
            }
        }
    }
    
    if(leftChatBubbleProperties) {
        NSString *bgColorString = [leftChatBubbleProperties objectForKey:@"BackgroundColor"];
        if(bgColorString){
            UIColor *bgColor = [UIColor colorFromRGBString:bgColorString];
            if(bgColor){
                self.leftChatBubble_BackgroundColor = bgColor;
            }
        }
        
        NSString *textColorString = [leftChatBubbleProperties objectForKey:@"TextColor"];
        if(textColorString){
            UIColor *textColor = [UIColor colorFromRGBString:textColorString];
            if(textColor){
                self.leftChatBubble_textColor = textColor;
            }
        }
        
        NSString *textFontString = [leftChatBubbleProperties objectForKey:@"TextFont"];
        NSString *textFontSize = [rightChatBubbleProperties objectForKey:@"TextSize"];
        if(textFontString && textFontSize && textFontString.length > 0 && textFontSize.length > 0){
            UIFont *customFont = [UIFont fontWithName:textFontString size:[textFontSize floatValue]];
            if(customFont != nil){
                self.leftChatBubble_textFont = customFont;
            }
        }
    }
    
    NSString *textFontString = [rightChatBubbleProperties objectForKey:@"MessageInfoLabelFont"];
    NSString *textFontSize = [rightChatBubbleProperties objectForKey:@"MessageInfoLabelSize"];
    if(textFontString && textFontSize && textFontString.length > 0 && textFontSize.length > 0){
        UIFont *customFont = [UIFont fontWithName:textFontString size:[textFontSize floatValue]];
        if(customFont != nil){
            self.messageInfoTextFont = customFont;
        }
    }
    
    NSString *textColorString = [leftChatBubbleProperties objectForKey:@"MessageInfoLabelColor"];
    if(textColorString){
        UIColor *textColor = [UIColor colorFromRGBString:textColorString];
        if(textColor){
            self.messageInfoTextColor = textColor;
        }
    }
}

/* Background Color - this goes as the background color for all the HelpStack screens */
- (UIColor *)getBackgroundColor {
    
    UIColor *bgColor = DEFAULT_BACKGROUNDCOLOR;

    NSString *bgImageFileName = [self.customThemeProperties objectForKey:@"BackgroundImageName"];
    if(bgImageFileName != nil){
        UIImage *bgImage = [UIImage imageNamed:bgImageFileName];
        if(bgImage != nil){
            bgColor = [UIColor colorWithPatternImage:bgImage];
            if(bgColor != nil){
                return bgColor;
            }
        }
    }

    NSString *bgColorString = [self.customThemeProperties objectForKey:@"BackgroundColor"];
    UIColor *customColor = [UIColor colorFromRGBString:bgColorString];
    if(customColor != nil){
        bgColor = customColor;
    }

    return bgColor;
}

/* NavigationBar Customization - This customization applies for all the navigation Bars in HelpStack screens */
- (void)customizeNavigationBar:(UINavigationBar *)navigationBar {

    if ([HSAppearance isIOS6]) {
        [navigationBar setTintColor:self.navBarBgColor]; //Sets the navbar bg color
    }
    else {
        [navigationBar setBarTintColor:self.navBarBgColor]; //Sets the navbar bg color
        [navigationBar setTintColor:self.navBarTintColor]; //Sets the navbar button tint color
    }
    
    
    if(self.navBarImageName){
        UIImage *bgImage = [UIImage imageNamed:self.navBarImageName];
        if(bgImage){
            [navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
        }
    }

    NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] init];
    [textAttributes setObject:self.navBarTitleColor forKey:NSForegroundColorAttributeName];
    [textAttributes setObject:self.navBarTitleFont forKey:NSFontAttributeName];
    [navigationBar setTitleTextAttributes:textAttributes];
    [navigationBar setBarStyle:UIBarStyleDefault];
    
}

#pragma mark - TableView Customization

/* TableView Customization - Setting a background color and separator color */
- (void)customizeTableView:(UITableView *)tableView {
    UIColor *tableViewBgColor = DEFAULT_TABLEVIEW_BACKGROUNDCOLOR;
    UIColor *separatorColor = DEFAULT_TABLEVIEW_SEPARATORCOLOR;
    if(self.customThemeProperties != nil){
        //Background Color
        NSDictionary *tableViewDict = [self.customThemeProperties objectForKey:@"TableView"];
        NSString *bgColorString = [tableViewDict objectForKey:@"BackgroundColor"];
        if(bgColorString != nil){
            UIColor *bgColor = [UIColor colorFromRGBString:bgColorString];
            if(bgColor != nil){
                tableViewBgColor = bgColor;
            }
        }
        
        //Separator Color
        NSString *separatorColorString = [tableViewDict objectForKey:@"SeparatorColor"];
        if(separatorColorString != nil){
            UIColor *customSeparatorColor = [UIColor colorFromRGBString:separatorColorString];
            if(customSeparatorColor != nil){
                separatorColor = customSeparatorColor;
            }
        }
    }

    tableView.backgroundColor = tableViewBgColor;
    tableView.separatorColor = separatorColor;
}

/* Setting a background Color for TableView section header */
- (void)customizeTableHeader:(UIView *)view {
    view.backgroundColor = self.headerBgColor;
}

/* Setting Header Title attributes */
- (void)customizeHeaderTitle:(UILabel *)title {
    title.font = self.headerTitleFont;
    title.textColor = self.headerTitleColor;
    title.backgroundColor = [UIColor clearColor];
}

/*  Cell customization - setting the cell background color.
    (Cell Labels will take up customization as per label properties
 */
- (void)customizeCell:(UITableViewCell *)cell {
    
    cell.backgroundColor = self.cellBgColor;
}

#pragma mark - Label Customization
- (void)customizeTextLabel:(UILabel *)title {
    
    title.font = self.labelFont;
    title.textColor = self.labelColor;
    title.backgroundColor = self.labelBgColor;
}

#pragma mark - Small Label Customization;
- (void)customizeSmallTextLabel:(UILabel *)title {
    
    title.font = self.messageInfoTextFont;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = self.messageInfoTextColor;
}

#pragma mark - Text View customization

- (void)customizeTextView:(UITextView *)textView {
    
    UIColor *bgColor = DEFAULT_TEXTVIEW_BACKGROUNDCOLOR;
    UIColor *textViewColor = DEFAULT_TEXTVIEW_TEXTCOLOR;
    UIFont *textFont = DEFAULT_TEXTVIEW_FONT;
    if(self.customThemeProperties != nil){
        NSDictionary *textDict = [self.customThemeProperties objectForKey:@"TextViewAttributes"];
        //BackgroundColor
        NSString *bgColorString = [textDict objectForKey:@"BackgroundColor"];

        if(bgColorString != nil){
            UIColor *custombgColor = [UIColor colorFromRGBString:bgColorString];
            if(custombgColor != nil){
                bgColor = custombgColor;
            }
        }
        
        //TextView Color
        NSString *titleColorString = [textDict objectForKey:@"TextViewColor"];
        if(titleColorString != nil){
            UIColor *customColor = [UIColor colorFromRGBString:titleColorString];
            if(customColor != nil){
                textViewColor = customColor;
            }
        }
        
        //Label Font
        NSString *textFontString = [textDict objectForKey:@"TextViewFont"];
        NSString *textFontSize = [textDict objectForKey:@"TextViewSize"];
        UIFont *customFont = [UIFont fontWithName:textFontString size:[textFontSize floatValue]];
        if(customFont != nil){
            textFont = customFont;
        }
    }
    textView.font = textFont;
    textView.textColor = textViewColor;
    textView.backgroundColor = bgColor;
}

#pragma mark - Button customization

- (void)customizeButton:(UIButton *)button {
    
    UIColor *bgColor = DEFAULT_BUTTON_BACKGROUNDCOLOR;
    UIColor *buttonTitleColor = DEFAULT_BUTTON_TITLECOLOR;
    UIFont *buttonTitleFont = DEFAULT_BUTTON_TITLEFONT;
    if(self.customThemeProperties != nil){
        NSDictionary *buttonDict = [self.customThemeProperties objectForKey:@"ButtonAttributes"];
        //BackgroundColor
        NSString *bgColorString = [buttonDict objectForKey:@"BackgroundColor"];
        if(bgColorString != nil){
            UIColor *custombgColor = [UIColor colorFromRGBString:bgColorString];
            if(custombgColor != nil){
                bgColor = custombgColor;
            }
        }
        
        //TextView Color
        NSString *titleColorString = [buttonDict objectForKey:@"TitleColor"];
        if(titleColorString != nil){
            UIColor *customColor = [UIColor colorFromRGBString:titleColorString];
            if(customColor != nil){
                buttonTitleColor = [UIColor whiteColor];
            }
        }
        
        //Label Font
        NSString *textFontString = [buttonDict objectForKey:@"TitleFont"];
        NSString *textFontSize = [buttonDict objectForKey:@"TitleSize"];
        UIFont *customFont = [UIFont fontWithName:textFontString size:[textFontSize floatValue]];
        if(customFont != nil){
            buttonTitleFont = customFont;
        }

    }
    button.titleLabel.font = buttonTitleFont;
    button.tintColor = buttonTitleColor;
    button.backgroundColor = bgColor;
}


# pragma mark - Chat settings

/**
    Customizing Chat bubbles - Chat bubbles on TicketDetailView screen takes up properties set from the tableview
    
    Right bubble (User's reply) - takes up table view header properties for background
    Left bubble (Staff's reply) - takes up table view cell properties for background
    Set the corresponding values to customize the chat bubbles
 */

- (void)customizeRightBubble:(UIView *)bubble {
    
    bubble.layer.borderColor = DEFAULT_CHATBUBBLE_BORDERCOLOR.CGColor;
    bubble.layer.borderWidth = 0.3;
    
    //bubble.backgroundColor = self.headerBgColor;
    
    bubble.backgroundColor = self.rightChatBubble_BackgroundColor;
}

- (void)customizeLeftBubble:(UIView *)bubble {
    
    bubble.layer.borderColor = DEFAULT_CHATBUBBLE_BORDERCOLOR.CGColor;
    bubble.layer.borderWidth = 0.3;
 
    //bubble.backgroundColor = self.cellBgColor;
    
    bubble.backgroundColor = self.leftChatBubble_BackgroundColor;
}

/* Chat texts appears same as the Cell view Texts - Takes up the label properties */
- (void)customizeBubbleText:(UITextView *)BubbleText {
    
    BubbleText.backgroundColor = [UIColor clearColor];
    BubbleText.textColor = self.labelColor;
    BubbleText.font = self.labelFont;
}

-(void)customizeRightBubbleText:(UITextView *)BubbleText{
    
    BubbleText.backgroundColor = [UIColor clearColor];
    BubbleText.textColor = self.rightChatBubble_textColor;
    BubbleText.font = self.rightChatBubble_textFont;
}

-(void)customizeLeftBubbleText:(UITextView *)BubbleText{
    
    BubbleText.backgroundColor = [UIColor clearColor];
    BubbleText.textColor = self.leftChatBubble_textColor;
    BubbleText.font = self.leftChatBubble_textFont;
}

-(UIFont *)getBubbleTextFont{
    
    return self.labelFont;
}

//is this an iPhone5
+ (BOOL)isTall {
    
    UIScreen* screen = [UIScreen mainScreen];
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && (screen.bounds.size.height * screen.scale) == 1136);
}

+ (BOOL)isIPad{
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return YES;
    }
    return NO;
}

+ (BOOL)isIOS6 {
    
    return [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0;
}

@end
