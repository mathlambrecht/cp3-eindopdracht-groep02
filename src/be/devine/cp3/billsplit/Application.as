/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit
{
import be.devine.cp3.billsplit.model.AppModel;

import feathers.themes.MinimalMobileTheme;

import starling.display.Sprite;


public class Application extends Sprite
{
    // Properties
    private var _appModel:AppModel;

    // Constructor
    public function Application()
    {
        _appModel = AppModel.getInstance();

        new MinimalMobileTheme();

        trace("[Application]");
    }

    // Methods
}
}
