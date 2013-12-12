/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 09:28
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.model {

import be.devine.cp3.billsplit.vo.FriendVO;

import flash.events.Event;
import flash.events.EventDispatcher;

public class BillModel extends EventDispatcher{

    // Properties
    public static const SPLITMETHOD_CHANGED:String = 'splitmethodChanged';
    public static const TOTAL_PRICE_CHANGED:String = 'totalPriceChanged';
    public static const TITLE_CHANGED:String = 'TitleChanged';
    public static const ARR_FRIENDS_CHANGED:String = 'arrFriendsChanged';
    public static const ARR_ITEMS_CHANGED:String = 'arrFriendsChanged';

    private var _id:String;
    private var _title:String;
    private var _datetime:String;
    private var _arrItems:Array;
    private var _arrFriends:Array;
    private var _totalPrice:Number;
    private var _splitMethod:String;
    private var _arrFriendPercentage:Array;
    private var _arrFriendItems:Array;

    // Constructor
    public function BillModel()
    {
        _arrItems = [];
        _arrFriends = [];
        _arrFriendItems = [];
        _arrFriendPercentage = [];
    }

    // Methods
    public function get title():String
    {
        return _title;
    }

    public function set title(value:String):void
    {
        if ( _title == value ) return;
        _title = value;
        dispatchEvent(new Event(TITLE_CHANGED));
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

    public function get arrFriendItems():Array {
        return _arrFriendItems;
    }

    public function set arrFriendItems(value:Array):void {
        _arrFriendItems = value;
    }

    public function get arrFriendPercentage():Array {
        return _arrFriendPercentage;
    }

    public function set arrFriendPercentage(value:Array):void {
        _arrFriendPercentage = value;
    }

    public function get arrFriends():Array {
        return _arrFriends;
    }

    public function set arrFriends(value:Array):void
    {
        if(_arrFriends == value) return;
        _arrFriends = value;
        dispatchEvent(new Event(ARR_FRIENDS_CHANGED));
    }

    public function get arrItems():Array {
        return _arrItems;
    }

    public function set arrItems(value:Array):void {
        if(_arrItems == value) return;
        _arrItems = value;
        dispatchEvent(new Event(ARR_ITEMS_CHANGED));
    }

    public function get datetime():String {
        return _datetime;
    }

    public function set datetime(value:String):void {
        _datetime = value;
    }

    public function get id():String {
        return _id;
    }

    public function set id(value:String):void {
        _id = value;
    }

    public function addFriend(friendVOAdd:FriendVO):void{

        var contains:Boolean;

        for each(var selectedFriendVO:FriendVO in _arrFriends)
        {
            if(FriendVO.equals(selectedFriendVO, friendVOAdd))
            {
                contains = true;
            }
        }

        if(!contains) arrFriends = arrFriends.concat(friendVOAdd);
    }

    public function removeFriend(friendVO:FriendVO):void
    {
        var contains:Boolean;

        for each(var selectedFriendVO:FriendVO in _arrFriends)
        {
            if(FriendVO.equals(selectedFriendVO, friendVO))
            {
                contains = true;
            }
        }

        if(contains){
            var newArrFriends:Array = [];

            for each(var friendVOAdd:FriendVO in _arrFriends)
            {
                if(!FriendVO.equals(friendVOAdd,friendVO)) newArrFriends.push(friendVOAdd);
            }

            arrFriends = newArrFriends;
        }
    }

    public function readObject(billVO:Object):void
    {
        id = billVO.id;
        title = billVO.title;
        datetime = billVO.datetime;
        arrItems = billVO.arrItems;
        arrFriends = billVO.arrFriends;
        totalPrice = billVO.totalPrice;

        // new bill -> splitmethod standaard op percentage
        if(billVO.splitMethod == null) splitMethod = 'percentage';
        if(billVO.splitMethod != null) splitMethod = billVO.splitMethod;

        arrFriendPercentage = billVO.arrFriendPercentage;
        arrFriendItems = billVO.arrFriendItems;
    }
}
}
