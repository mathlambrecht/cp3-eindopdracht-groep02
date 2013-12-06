package be.devine.cp3.billsplit.config
{
import feathers.themes.MetalWorksMobileTheme;

public class Config
{
    public static var JSON_FILENAME:String = 'bills.json';

    public function Config(){}

    public function setTheme():void
    {
        new MetalWorksMobileTheme();
    }
}
}
