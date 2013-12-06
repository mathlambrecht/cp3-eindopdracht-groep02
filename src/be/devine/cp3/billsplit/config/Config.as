package be.devine.cp3.billsplit.config
{
import feathers.themes.MetalWorksMobileTheme;

public class Config
{
    public static const JSON_FILENAME:String = 'bills.json';

    // pages
    public static const HOME:String = 'Home';
    public static const OLD_BILLS:String = 'OldBills';
    public static const NEW_BILL:String = 'NewBill';

    public function Config(){}

    public function setTheme():void
    {
        new MetalWorksMobileTheme();
    }
}
}
