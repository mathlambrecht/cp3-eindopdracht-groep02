/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 10:06
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.navigator {
import feathers.controls.ScreenNavigator;

import starling.display.DisplayObject;

public class ScreenNavigatorWithHistory extends ScreenNavigator{

    // Properties
    private var _history:Array;

    // Constructor
    public function ScreenNavigatorWithHistory()
    {
        _history = [];
    }

    // Methods
    override public function showScreen(id:String):DisplayObject
    {
        _history.push(id);
        return super.showScreen(id);
    }

    public function showScreenAdvanced(id:String):DisplayObject
    {
        return super.showScreen(id);
    }

    public function goBack(step:uint):String
    {
        if (_history.length > 1) {

            trace('ScreenNavigatorWithHistory' + _history[_history.length - 1 - step]);
            return _history[_history.length - 1 - step];
        }
        return _history[0];
    }

    public function clearHistory():void
    {
        _history = [];
    }

    public function get history():Array {
        return _history;
    }

    public function set history(value:Array):void {
        _history = value;
    }
}
}
