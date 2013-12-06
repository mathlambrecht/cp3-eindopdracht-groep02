/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 20:54
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.navigator.ScreenNavigatorWithHistory;
import be.devine.cp3.billsplit.view.pages.Home;
import be.devine.cp3.billsplit.view.pages.NewBill;
import be.devine.cp3.billsplit.view.pages.OldBills;
import be.devine.cp3.billsplit.view.pages.SplitBill;

import feathers.controls.Screen;

import feathers.controls.ScreenNavigatorItem;

import flash.events.Event;

import starling.display.Sprite;

public class Content extends Sprite{

    // Properties
    private var _appModel:AppModel;
    private var _navigator:ScreenNavigatorWithHistory;
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
        var newBill:ScreenNavigatorItem = new ScreenNavigatorItem( new NewBill() );
        var oldBills:ScreenNavigatorItem = new ScreenNavigatorItem( new OldBills() );
        var splitBill:ScreenNavigatorItem = new ScreenNavigatorItem( new SplitBill() );
        _arrScreens.push(home,newBill,oldBills,splitBill);

        _navigator.addScreen( Config.HOME , home );
        _navigator.addScreen( Config.NEW_BILL , newBill );
        _navigator.addScreen( Config.OLD_BILLS , oldBills );
        _navigator.addScreen( Config.SPLIT_BILL , splitBill );
        addChild(_navigator);

        _appModel.currentPage = Config.HOME;
    }

    private function changeScreenHandler(event:Event):void
    {
        trace('[Content] Change screen');

        _navigator.showScreen(_appModel.currentPage);
    }

    public function setSize(width:Number,height:Number):void
    {
        _navigator.height = height;
        _navigator.width = width;

        for each(var screenNavigatorItem:ScreenNavigatorItem in _arrScreens){
            var screen:Screen = screenNavigatorItem.screen as Screen;
            screen.setSize(width,height);
        }

    }
}
}
