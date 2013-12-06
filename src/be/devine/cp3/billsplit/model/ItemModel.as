/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 09:29
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.model {
import starling.events.EventDispatcher;

public class ItemModel extends EventDispatcher{

    // Properties
    private var _id:uint;
    private var _description:String;
    private var _price:Number;
    private var _amount:uint;

    // Constructor
    public function ItemModel() {
    }

    // Methods
    public function get id():uint {
        return _id;
    }

    public function set id(value:uint):void {
        _id = value;
    }

    public function get description():String {
        return _description;
    }

    public function set description(value:String):void {
        _description = value;
    }

    public function get price():Number {
        return _price;
    }

    public function set price(value:Number):void {
        _price = value;
    }

    public function get amount():uint {
        return _amount;
    }

    public function set amount(value:uint):void {
        _amount = value;
    }
}
}
