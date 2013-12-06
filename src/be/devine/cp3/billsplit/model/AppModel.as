package be.devine.cp3.billsplit.model
{

import flash.events.Event;
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher
{
    //---------------------------------------------------------------
    //-------------------------- Properties -------------------------
    //---------------------------------------------------------------
    public static const ARRAY_BILLS_VO_CHANGED:String = 'arrBillsVoChanged';
    public static const ARRAY_FRIENDS_VO_CHANGED:String = 'arrFriendsVoChanged';

    public static const CURRENT_PAGE_CHANGED:String = 'currentPageChanged';

    private static var _instance:AppModel;

    private var _arrBillsVO:Array;
    private var _arrFriendsVO:Array;

    private var _currentPage:String;

    private var _bills:Array;
    private var _friends:Array;
    private var _selectedFriends:Array;

    private var _splitMethod:Array;

    private var _date:Date;
    private var _title:String;
    private var _items:Array;
    private var _totalPrice:Number;

    //---------------------------------------------------------------
    //-------------------------- Singleton --------------------------
    //---------------------------------------------------------------
    public static function getInstance():AppModel
    {
        if(_instance == null)
        {
            _instance = new AppModel(new Enforcer());
        }

        return _instance;
    }

    //---------------------------------------------------------------
    //-------------------------- Constructor ------------------------
    //---------------------------------------------------------------
    public function AppModel(event:Enforcer)
    {
        if(event == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        trace('[AppModel]');

        _arrBillsVO = new Array();
        _arrFriendsVO = new Array();
    }

    //---------------------------------------------------------------
    //-------------------------- Methods ----------------------------
    //---------------------------------------------------------------
    public function get arrVO():Array
    {
        return _arrBillsVO;
    }

    public function set arrVO(value:Array):void
    {
        if(_arrBillsVO != value)
        {
            _arrBillsVO = value;
            dispatchEvent(new Event(ARRAY_BILLS_VO_CHANGED));
        }
    }

    public function get arrFriendsVO():Array
    {
        return _arrFriendsVO;
    }

    public function set arrFriendsVO(value:Array):void
    {
        if(_arrFriendsVO != value)
        {
            _arrFriendsVO = value;
            dispatchEvent(new Event(ARRAY_FRIENDS_VO_CHANGED));
        }
    }


    public function get bills():Array
    {
        return _bills;
    }

    public function set bills(value:Array):void
    {
        _bills = value;
    }

    public function get friends():Array {
        return _friends;
    }

    public function set friends(value:Array):void {
        _friends = value;
    }

    public function get selectedFriends():Array {
        return _selectedFriends;
    }

    public function set selectedFriends(value:Array):void {
        _selectedFriends = value;
    }

    public function get splitMethod():Array {
        return _splitMethod;
    }

    public function set splitMethod(value:Array):void {
        _splitMethod = value;
    }

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

    public function get currentPage():String {
        return _currentPage;
    }

    public function set currentPage(value:String):void {
        if ( _currentPage == value ) return;
        _currentPage = value;
        dispatchEvent(new Event(CURRENT_PAGE_CHANGED));
    }



}
}

internal class Enforcer{};
