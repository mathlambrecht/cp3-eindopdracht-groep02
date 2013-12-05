package be.devine.cp3.billsplit.model
{
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher
{
    // Properties
    private static var _instance:AppModel;

    /* todo: properties
    *
    *   item array
    *   total price
    *   friends array
    *   old bills object
    *   ..
    *
    *
    */

    //Singleton
    public static function getInstance():AppModel
    {
        if(_instance == null)
        {
            _instance = new AppModel(new Enforcer());
        }

        return _instance;
    }

    // Constructor
    public function AppModel(event:Enforcer)
    {
        if(event == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        trace('[AppModel]');
    }

    // Methods
}
}

internal class Enforcer{};
