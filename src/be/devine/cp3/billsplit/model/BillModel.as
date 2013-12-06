/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 09:28
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.model {
import starling.events.EventDispatcher;

public class BillModel extends EventDispatcher{

    // Properties
    private var _splitMethod:String;

    private var _date:Date;
    private var _title:String;
    private var _items:Array;
    private var _friends:Array;
    private var _totalPrice:Number;

    // Constructor
    public function BillModel() {
    }

    // Methods
    public function get date():Date {
        return _date;
    }

    public function set date(value:Date):void {
        _date = value;
    }

    public function get title():String {
        return _title;
    }

    public function set title(value:String):void {
        _title = value;
    }

    public function get items():Array {
        return _items;
    }

    public function set items(value:Array):void {
        _items = value;
    }

    public function get totalPrice():Number {
        return _totalPrice;
    }

    public function set totalPrice(value:Number):void {
        _totalPrice = value;
    }

    public function get splitMethod():String {
        return _splitMethod;
    }

    public function set splitMethod(value:String):void {
        _splitMethod = value;
    }

    public function get friends():Array {
        return _friends;
    }

    public function set friends(value:Array):void {
        _friends = value;
    }
}
}
