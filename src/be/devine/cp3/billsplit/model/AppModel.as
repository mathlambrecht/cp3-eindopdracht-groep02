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
    public static const NEW_BILL:String = 'newBill';

    private static var _instance:AppModel;

    private var _arrBillsVO:Array;
    private var _arrFriendsVO:Array;

    private var _currentPage:String;

    private var _bills:Array;
    private var _currentBill:BillModel;
    private var _friends:Array;

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

        _arrBillsVO = [];
        _arrFriendsVO = [];
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

    public function get friends():Array
    {
        return _friends;
    }

    public function set friends(value:Array):void
    {
        _friends = value;
    }

    public function get currentPage():String
    {
        return _currentPage;
    }

    public function set currentPage(value:String):void
    {
        if ( _currentPage == value ) return;
        _currentPage = value;
        dispatchEvent(new Event(CURRENT_PAGE_CHANGED));
    }

    public function get currentBill():BillModel
    {
        return _currentBill;
    }

    public function set currentBill(value:BillModel):void
    {
        if ( _currentBill == value ) return;
        _currentBill = value;
        dispatchEvent(new Event(NEW_BILL));
    }
}
}

internal class Enforcer{}
