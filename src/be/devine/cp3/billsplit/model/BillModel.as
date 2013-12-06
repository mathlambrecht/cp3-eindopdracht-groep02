/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 09:28
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.model {

import flash.events.Event;
import flash.events.EventDispatcher;

public class BillModel extends EventDispatcher{

    // Properties
    public static const SPLITMETHOD_CHANGED:String = 'splitmethodChanged';
    public static const TOTAL_PRICE_CHANGED:String = 'totalPriceChanged';

    private var _date:Date;
    private var _title:String;
    private var _items:Array;
    private var _friends:Array;
    private var _totalPrice:Number;
    private var _splitMethod:String = "percentage";

    // Constructor
    public function BillModel() {}

    // Methods
    public function get date():Date
    {
        return _date;
    }

    public function set date(value:Date):void
    {
        _date = value;
    }

    public function get title():String
    {
        return _title;
    }

    public function set title(value:String):void
    {
        if ( _title == value ) return;
        _title = value;
    }

    public function get items():Array
    {
        return _items;
    }

    public function set items(value:Array):void
    {
        _items = value;
    }

    public function get totalPrice():Number
    {
        return _totalPrice;
    }

    public function set totalPrice(value:Number):void
    {
        if(_totalPrice == value) return;

        if(isNaN(value)) value = 0;

        _totalPrice = value;
        dispatchEvent(new Event(TOTAL_PRICE_CHANGED));
    }

    public function get splitMethod():String
    {
        return _splitMethod;
    }

    public function set splitMethod(value:String):void
    {
        if(_splitMethod == value) return;
        _splitMethod = value;
        dispatchEvent(new Event(SPLITMETHOD_CHANGED));
    }

    public function get friends():Array
    {
        return _friends;
    }

    public function set friends(value:Array):void
    {
        _friends = value;
    }
}
}
