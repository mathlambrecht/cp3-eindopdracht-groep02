package be.devine.cp3.billsplit.model
{

import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.vo.BillVO;
import be.devine.cp3.billsplit.vo.FriendItemVO;
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
    public static const CURRENT_BILL_CHANGED:String = 'currentBillChanged';

    public static const SAVE_BILL_LOCAL:String = 'saveBillLocal';

    private static var _instance:AppModel;

    private var _arrBillsVO:Vector.<BillVO>;
    private var _arrFriendsVO:Vector.<FriendVO>;

    private var _currentPage:String;
    private var _currentBillVO:BillVO;

    private var _isAddFriendInBill:Boolean = false;
    private var _isNewBill:Boolean = false;
    private var _isNewFriend:Boolean = false;
    private var _isNewJSONFile:Boolean = false;

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

    public function addFriend(friendVO:FriendVO):void
    {
        arrFriendsVO = _arrFriendsVO.concat(new <FriendVO>[friendVO]);
    }

    public function get currentBillVO():BillVO
    {
        return _currentBillVO;
    }

    public function set currentBillVO(value:BillVO):void
    {
        if(_currentBillVO == value) return;
        _currentBillVO = value;
        dispatchEvent(new Event(CURRENT_BILL_CHANGED));
    }

    public function saveBill():void
    {
        dispatchEvent(new Event(SAVE_BILL_LOCAL));
    }

    public function get isAddFriendInBill():Boolean {
        return _isAddFriendInBill;
    }

    public function set isAddFriendInBill(value:Boolean):void {
        _isAddFriendInBill = value;
    }

    public function get isNewBill():Boolean {
        return _isNewBill;
    }

    public function set isNewBill(value:Boolean):void {
        _isNewBill = value;

        trace('isnewbill state = ' + value);
    }

    public function get isNewFriend():Boolean {
        return _isNewFriend;
    }

    public function set isNewFriend(value:Boolean):void {
        _isNewFriend = value;
    }

    public function get isNewJSONFile():Boolean {
        return _isNewJSONFile;
    }

    public function set isNewJSONFile(value:Boolean):void {
        _isNewJSONFile = value;
    }
}
}

internal class Enforcer{}
