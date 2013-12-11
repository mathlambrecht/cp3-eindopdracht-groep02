package be.devine.cp3.billsplit.view
{
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.navigator.ScreenNavigatorWithHistory;
import be.devine.cp3.billsplit.view.pages.bills.AddItem;
import be.devine.cp3.billsplit.view.pages.bills.BillFriends;
import be.devine.cp3.billsplit.view.pages.bills.BillItems;
import be.devine.cp3.billsplit.view.pages.bills.BillPrice;
import be.devine.cp3.billsplit.view.pages.friends.AddFriend;
import be.devine.cp3.billsplit.view.pages.friends.Friends;
import be.devine.cp3.billsplit.view.pages.Home;
import be.devine.cp3.billsplit.view.pages.bills.NewBill;
import be.devine.cp3.billsplit.view.pages.bills.OldBills;
import be.devine.cp3.billsplit.view.pages.bills.Results;
import be.devine.cp3.billsplit.view.pages.bills.SplitBill;

import feathers.controls.Screen;
import feathers.controls.ScreenNavigatorItem;
import feathers.motion.transitions.ScreenSlidingStackTransitionManager;

import flash.events.Event;

import starling.animation.Transitions;

public class Content extends Screen
{
    // Properties
    private var _appModel:AppModel;
    private var _navigator:ScreenNavigatorWithHistory;
    private var _transitionManager:ScreenSlidingStackTransitionManager;
    private var _arrScreens:Array;

    // Constructor
    public function Content(navigator:ScreenNavigatorWithHistory)
    {
        trace('[Content]');
        _arrScreens =[];

        _navigator = navigator;
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, changeScreenHandler);

        createNavigator();
    }

    // Methods
    private function createNavigator():void
    {
        var home:ScreenNavigatorItem = new ScreenNavigatorItem( new Home() );
        var friends:ScreenNavigatorItem = new ScreenNavigatorItem( new Friends() );
        var addFriend:ScreenNavigatorItem = new ScreenNavigatorItem( new AddFriend() );
        var oldBills:ScreenNavigatorItem = new ScreenNavigatorItem( new OldBills() );
        var newBill:ScreenNavigatorItem = new ScreenNavigatorItem( new NewBill() );
        var billPrice:ScreenNavigatorItem = new ScreenNavigatorItem( new BillPrice() );
        var billItems:ScreenNavigatorItem = new ScreenNavigatorItem( new BillItems() );
        var addItem:ScreenNavigatorItem = new ScreenNavigatorItem( new AddItem() );
        var billFriends:ScreenNavigatorItem = new ScreenNavigatorItem( new BillFriends() );
        var splitBill:ScreenNavigatorItem = new ScreenNavigatorItem( new SplitBill() );
        var results:ScreenNavigatorItem = new ScreenNavigatorItem( new Results() );

        _navigator.addScreen( Config.HOME , home );
        _navigator.addScreen( Config.FRIENDS , friends );
        _navigator.addScreen( Config.ADD_FRIEND , addFriend );
        _navigator.addScreen( Config.OLD_BILLS , oldBills );
        _navigator.addScreen( Config.NEW_BILL , newBill );
        _navigator.addScreen( Config.BILL_PRICE , billPrice );
        _navigator.addScreen( Config.BILL_ITEMS , billItems );
        _navigator.addScreen( Config.ADD_ITEM , addItem );
        _navigator.addScreen( Config.BILL_FRIENDS , billFriends );
        _navigator.addScreen( Config.SPLIT_BILL , splitBill );
        _navigator.addScreen( Config.RESULTS , results );
        this.addChild(_navigator);

        _transitionManager = new ScreenSlidingStackTransitionManager( _navigator );
        _transitionManager.duration = 0.4;
        _transitionManager.ease = Transitions.EASE_OUT;

        _appModel.currentPage = Config.HOME;
    }

    private function changeScreenHandler(event:Event):void
    {
        _navigator.showScreen(_appModel.currentPage);
    }
}
}
