package be.devine.cp3.billsplit.model
{

import be.devine.cp3.billsplit.utils.MathUtilities;
import be.devine.cp3.billsplit.vo.FriendVO;
import be.devine.cp3.billsplit.vo.ItemVO;

import flash.events.Event;
import flash.events.EventDispatcher;

public class BillModel extends EventDispatcher
{
    // Properties
    public static const TITLE_CHANGED:String = 'TitleChanged';
    public static const TOTAL_PRICE_CHANGED:String = 'totalPriceChanged';
    public static const SPLITMETHOD_CHANGED:String = 'splitmethodChanged';

    public static const ARR_FRIENDS_CHANGED:String = 'arrFriendsChanged';
    public static const ARR_ITEMS_CHANGED:String = 'arrFriendsChanged';

    public static const ARR_FRIEND_PERCENTAGE_CHANGED:String = 'arrFriendPercentageChanged';
    public static const ARR_FRIEND_ITEMS_CHANGED:String = 'arrFriendItemsChanged';

    public static const BILL_CHANGED:String = 'billChanged';
    public static const PERCENTAGE_LEFT_CHANGED:String = 'percentageLeftChanged';

    private static var _instance:BillModel;
    private var _appModel:AppModel;

    private var _title:String;
    private var _totalPrice:Number;
    private var _splitMethod:String;

    private var _arrItems:Array;
    private var _arrFriends:Array;

    private var _arrFriendPercentage:Array;
    private var _arrFriendItems:Array;

    private var _percentageLeft:Number;

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
        dispatchEvent(new Event(ARR_FRIEND_PERCENTAGE_CHANGED));
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

    public function get percentageLeft():Number
    {
        return _percentageLeft;
    }

    public function set percentageLeft(value:Number):void
    {
        if(_percentageLeft == value) return;
        _percentageLeft = value;
        dispatchEvent(new Event(PERCENTAGE_LEFT_CHANGED));
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
        title = _appModel.currentBillVO.title;
        arrItems = _appModel.currentBillVO.arrItems;
        arrFriends = _appModel.currentBillVO.arrFriends;
        totalPrice = _appModel.currentBillVO.totalPrice;
        arrFriendItems = _appModel.currentBillVO.arrFriendItems;
        arrFriendPercentage = _appModel.currentBillVO.arrFriendPercentage;

        // new bill -> split method standard op percentage
        if(_appModel.currentBillVO.splitMethod == null) splitMethod = 'percentage';
        if(_appModel.currentBillVO.splitMethod != null) splitMethod = _appModel.currentBillVO.splitMethod;

        arrFriendPercentage = _appModel.currentBillVO.arrFriendPercentage;
        arrFriendItems = _appModel.currentBillVO.arrFriendItems;

        _percentageLeft = MathUtilities.calculatePercentageLeft();

        dispatchEvent(new Event(BILL_CHANGED));
    }
}
}

internal class Enforcer{}
