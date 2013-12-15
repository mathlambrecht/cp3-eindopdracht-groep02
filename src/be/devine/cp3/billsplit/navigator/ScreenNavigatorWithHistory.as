package be.devine.cp3.billsplit.navigator
{
import be.devine.cp3.billsplit.config.Config;

import feathers.controls.ScreenNavigator;

import starling.display.DisplayObject;

public class ScreenNavigatorWithHistory extends ScreenNavigator
{
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

    public function goBack(currentPage:String):String
    {
        var screen:String = Config.HOME;

        if(_history.length == 0) return screen;

        switch (currentPage){
            case Config.FRIENDS: screen = _history[_history.length-2];
                break;
            case Config.ADD_FRIEND: screen = _history[_history.length-2];
                break;
            case Config.OLD_BILLS: screen = _history[_history.length-2];
                break;
            case
                Config.NEW_BILL: screen =
                    (_history[_history.length-1] == _history[_history.length-3]
                    || _history[_history.length-1] == _history[_history.length-5]) ? Config.OLD_BILLS : _history[_history.length-2];
                break;
            case Config.BILL_FRIENDS: screen = Config.NEW_BILL;
                break;
            case Config.BILL_ITEMS: screen = Config.NEW_BILL;
                break;
            case Config.BILL_PRICE: screen = Config.NEW_BILL;
                break;
            case Config.SPLIT_BILL_ABSOLUTE: screen = Config.NEW_BILL;
                break;
            case Config.SPLIT_BILL_PERCENTAGE: screen = Config.NEW_BILL;
                break;
            case Config.RESULTS: screen = _history[_history.length-2];
                break;
        }

        return screen;
    }

    public function clearHistory():void
    {
        _history = [];
    }

    public function get history():Array
    {
        return _history;
    }

    public function set history(value:Array):void
    {
        _history = value;
    }
}
}
