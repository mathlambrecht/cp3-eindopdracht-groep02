package be.devine.cp3.billsplit.config
{
import feathers.themes.MetalWorksMobileTheme;

public class Config
{
    public static const JSON_FILENAME:String = 'bills.json';

    // pages
    public static const HOME:String = 'Home';
    public static const OLD_BILLS:String = 'Old bills';
    public static const NEW_BILL:String = 'New bill';

    public function Config(){}

    public function setTheme():void
    {
        new MetalWorksMobileTheme();
    }
}
}
