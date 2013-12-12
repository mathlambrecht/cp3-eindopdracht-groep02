package be.devine.cp3.billsplit.config
{
import feathers.themes.MetalWorksMobileTheme;

public class Config
{
    public static const JSON_FILENAME:String = 'bills.json';
    public static const HEADER_HEIGHT:Number = 65;
    public static const MENU_MARGIN:Number = 120;

    // pages
    public static const HOME:String = 'Home';
    public static const MENU:String = 'Menu';
    public static const FRIENDS:String = 'Friends';
    public static const ADD_FRIEND:String = 'AddFriend';
    public static const OLD_BILLS:String = 'OldBills';
    public static const NEW_BILL:String = 'NewBill';
    public static const BILL_FRIENDS:String = 'BillFriends';
    public static const BILL_PRICE:String = 'BillPrice';
    public static const BILL_ITEMS:String = 'BillItems';
    public static const ADD_ITEM:String = 'AddItem';
    public static const SPLIT_BILL_PERCENTAGE:String = 'SplitBillPercentage';
    public static const SPLIT_BILL_ABSOLUTE:String = 'SplitBillAbsolute';
    public static const RESULTS:String = 'Results';

    public function Config(){}

    public function setTheme():void
    {
        new MetalWorksMobileTheme();
    }
}
}
