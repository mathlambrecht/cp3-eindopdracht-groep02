package be.devine.cp3.billsplit.model
{

import be.devine.cp3.billsplit.vo.BillVO;
import be.devine.cp3.billsplit.vo.FriendVO;

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

    private var _arrBillsVO:Vector.<BillVO>;
    private var _arrFriendsVO:Vector.<FriendVO>;

    private var _currentPage:String;
    private var _currentBill:BillModel;

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

        _arrBillsVO = new Vector.<BillVO>();
        _arrFriendsVO = new Vector.<FriendVO>();

        _currentBill = new BillModel();
    }

    //---------------------------------------------------------------
    //-------------------------- Methods ----------------------------
    //---------------------------------------------------------------
    public function get arrBillsVO():Vector.<BillVO>
    {
        return _arrBillsVO;
    }

    public function set arrBillsVO(value:Vector.<BillVO>):void
    {
        if(_arrBillsVO != value)
        {
            _arrBillsVO = value;

            dispatchEvent(new Event(ARRAY_BILLS_VO_CHANGED));
        }
    }

    public function get arrFriendsVO():Vector.<FriendVO>
    {
        return _arrFriendsVO;
    }

    public function set arrFriendsVO(value:Vector.<FriendVO>):void
    {
        if(_arrFriendsVO != value)
        {
            _arrFriendsVO = value;

            dispatchEvent(new Event(ARRAY_FRIENDS_VO_CHANGED));
        }
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
    }
}
}

internal class Enforcer{}
