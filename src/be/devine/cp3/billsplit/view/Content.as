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

import feathers.controls.ScreenNavigatorItem;

import flash.events.Event;

import starling.display.Sprite;

public class Content extends Sprite{

    // Properties
    private var _appModel:AppModel;
    private var _navigator:ScreenNavigatorWithHistory;

    // Constructor
    public function Content(navigator:ScreenNavigatorWithHistory)
    {
        trace('[Content]');

        _navigator = navigator;
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, changeScreenHandler);

        createNavigator();
    }

    // Methods
    private function createNavigator():void{

        _navigator.addScreen( Config.HOME , new ScreenNavigatorItem( Home ) );
        _navigator.addScreen( Config.NEW_BILL , new ScreenNavigatorItem( NewBill ) );
        _navigator.addScreen( Config.OLD_BILLS , new ScreenNavigatorItem( OldBills ) );
        addChild(_navigator);

        _navigator.showScreen(Config.HOME);
    }

    public function setSize(width:Number,height:Number):void{
        _navigator.height = height;
        _navigator.width = width;
    }

    private function changeScreenHandler(event:Event):void {
        trace('[Content] Change screen');

        _navigator.showScreen(_appModel.currentPage);
    }
}
}
