package be.devine.cp3.billsplit.model
{

import be.devine.cp3.billsplit.vo.FriendVO;
import be.devine.cp3.billsplit.vo.ItemVO;

import flash.events.Event;
import flash.events.EventDispatcher;

public class BillModel extends EventDispatcher
{
    // Properties
    public static const SPLITMETHOD_CHANGED:String = 'splitmethodChanged';
    public static const TOTAL_PRICE_CHANGED:String = 'totalPriceChanged';
    public static const TITLE_CHANGED:String = 'TitleChanged';
    public static const ARR_FRIENDS_CHANGED:String = 'arrFriendsChanged';
    public static const ARR_ITEMS_CHANGED:String = 'arrFriendsChanged';
    public static const BILL_CHANGED:String = 'billChanged';

    private static var _instance:BillModel;
    private var _appModel:AppModel;

    private var _title:String;
    private var _datetime:String;
    private var _arrItems:Array;
    private var _arrFriends:Array;
    private var _totalPrice:Number;
    private var _splitMethod:String;
    private var _arrFriendPercentage:Array;
    private var _arrFriendItems:Array;

    //---------------------------------------------------------------
    //-------------------------- Singleton --------------------------
    //---------------------------------------------------------------
    public static function getInstance():BillModel
    {
        if(_instance == null)
        {
            _instance = new BillModel(new Enforcer());
        }

        return _instance;
    }

    //---------------------------------------------------------------
    //-------------------------- Constructor ------------------------
    //---------------------------------------------------------------
    public function BillModel(event:Enforcer)
    {
        if(event == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.CURRENT_BILL_CHANGED, readObject);

        _arrItems = [];
        _arrFriends = [];
        _arrFriendItems = [];
        _arrFriendPercentage = [];
    }

    //---------------------------------------------------------------
    //-------------------------- Methods ----------------------------
    //---------------------------------------------------------------
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

    public function get arrFriendItems():Array
    {
        return _arrFriendItems;
    }

    public function set arrFriendItems(value:Array):void
    {
        if(_arrFriendItems == value) return;
        _arrFriendItems = value;
    }

    public function get arrFriendPercentage():Array
    {
        return _arrFriendPercentage;
    }

    public function set arrFriendPercentage(value:Array):void
    {
        if(_arrFriendPercentage == value) return;
        _arrFriendPercentage = value;
    }

    public function get arrFriends():Array
    {
        return _arrFriends;
    }

    public function set arrFriends(value:Array):void
    {
        if(_arrFriends == value) return;
        _arrFriends = value;
        dispatchEvent(new Event(ARR_FRIENDS_CHANGED));
    }

    public function get arrItems():Array
    {
        return _arrItems;
    }

    public function set arrItems(value:Array):void
    {
        if(_arrItems == value) return;
        _arrItems = value;
        dispatchEvent(new Event(ARR_ITEMS_CHANGED));
    }

    public function get datetime():String
    {
        return _datetime;
    }

    public function set datetime(value:String):void
    {
        _datetime = value;
    }

    public function addItem(itemVO:ItemVO):void
    {
        arrItems = arrItems.concat(itemVO);
    }

    public function removeItem(itemVO:ItemVO):void
    {
        arrItems.splice(itemVO);
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

        if(contains)
        {
            var newArrFriends:Array = [];

            for each(var friendVOAdd:FriendVO in _arrFriends)
            {
                if(!FriendVO.equals(friendVOAdd,friendVO)) newArrFriends.push(friendVOAdd);
            }

            arrFriends = newArrFriends;
        }
    }

    public function readObject(event:Event):void
    {
        title = _appModel.arrBillsVO[_appModel.currentBillIndex].title;
        datetime = _appModel.arrBillsVO[_appModel.currentBillIndex].datetime;
        arrItems = _appModel.arrBillsVO[_appModel.currentBillIndex].arrItems;
        arrFriends = _appModel.arrBillsVO[_appModel.currentBillIndex].arrFriends;
        totalPrice = _appModel.arrBillsVO[_appModel.currentBillIndex].totalPrice;
        arrFriendItems = _appModel.arrBillsVO[_appModel.currentBillIndex].arrFriendItems;
        arrFriendPercentage = _appModel.arrBillsVO[_appModel.currentBillIndex].arrFriendPercentage;

        // new bill -> splitmethod standaard op percentage
        if(_appModel.arrBillsVO[_appModel.currentBillIndex].splitMethod == null) splitMethod = 'percentage';
        if(_appModel.arrBillsVO[_appModel.currentBillIndex].splitMethod != null) splitMethod = _appModel.arrBillsVO[_appModel.currentBillIndex].splitMethod;

        arrFriendPercentage = _appModel.arrBillsVO[_appModel.currentBillIndex].arrFriendPercentage;
        arrFriendItems = _appModel.arrBillsVO[_appModel.currentBillIndex].arrFriendItems;

        dispatchEvent(new Event(BILL_CHANGED));
    }
}
}

internal class Enforcer{}
