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
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.navigator.ScreenNavigatorWithHistory;
import be.devine.cp3.billsplit.view.pages.Menu;

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.Screen;
import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import flash.events.Event;

import starling.display.DisplayObject;
import starling.events.Event;

public class Header extends Screen {

    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;
    private var _navigator:ScreenNavigatorWithHistory;

    private var _header:feathers.controls.Header;
    private var _backButton:Button;
    private var _menuButton:Button;

    private var _menuNavigator:ScreenNavigator;

    // Constructor
    public function Header(navigator:ScreenNavigatorWithHistory)
    {
        trace('[Header]');

        _navigator = navigator;
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.CURRENT_BILL_CHANGED,clearScreen);
        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED,currentPageChanged);

        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.PERCENTAGE_LEFT_CHANGED, percentageLeftChangedHandler);

        _menuNavigator = new ScreenNavigator();
        _menuNavigator.addScreen( Config.MENU , new ScreenNavigatorItem( Menu ) );

        _header = new feathers.controls.Header();
        _header.title = 'Billit';
        addChild(_header);

        _backButton = new Button();
        _backButton.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
        _backButton.addEventListener(starling.events.Event.TRIGGERED, backButtonTriggeredHandler);

        _menuButton = new Button();
        _menuButton.label = 'Menu';
        _menuButton.addEventListener(starling.events.Event.TRIGGERED, menuButtonTriggeredHandler);

        _header.leftItems = new <DisplayObject>[ _backButton ];
        _header.rightItems = new <DisplayObject>[ _menuButton ];
    }

    // Methods
    private function backButtonTriggeredHandler(event:starling.events.Event):void
    {
       _appModel.currentPage = _navigator.goBack(_appModel.currentPage);
    }

    private function menuButtonTriggeredHandler(event:starling.events.Event):void
    {
        if (_menuNavigator.activeScreenID != Config.MENU)
        {
            _menuNavigator.showScreen( Config.MENU );
        } else
        {
            _menuNavigator.clearScreen();
        }
    }

    private function currentPageChanged(event:flash.events.Event):void
    {
        var title:String = '';

        switch (_appModel.currentPage){
            case Config.HOME: title = 'Billit';
                break;
            case Config.FRIENDS: title = 'Your friends';
                break;
            case Config.ADD_FRIEND: title = 'Add friend';
                break;
            case Config.OLD_BILLS: title = 'Old bills';
                break;
            case Config.NEW_BILL: title = 'Bill details';
                break;
            case Config.BILL_FRIENDS: title = 'Friends to share with';
                break;
            case Config.BILL_ITEMS: title = 'Items bought';
                break;
            case Config.BILL_PRICE: title = 'Total bill price';
                break;
            case Config.SPLIT_BILL_ABSOLUTE: title = 'Divide';
                break;
            case Config.SPLIT_BILL_PERCENTAGE: title = _billModel.percentageLeft + '% left';
                break;
            case Config.RESULTS: title = 'Results';
                break;
        }

        _header.title = title;
        clearScreen();
    }

    private function clearScreen(event:flash.events.Event = null):void
    {
        if (_menuNavigator.activeScreenID == Config.MENU) _menuNavigator.clearScreen();
        _backButton.visible = (!(_appModel.currentPage == Config.HOME && _navigator.history.length == 0));
    }

    private function percentageLeftChangedHandler(event:flash.events.Event):void
    {
        _header.title = (_appModel.currentPage == Config.SPLIT_BILL_PERCENTAGE) ?  _billModel.percentageLeft + '% left' : _header.title ;
    }

    override protected function initialize():void
    {
        addChild(_header);
        addChild(_menuNavigator);
    }

    override public function setSize(w:Number, h:Number):void
    {
        _header.setSize(stage.stageWidth,Config.HEADER_HEIGHT);
        _menuNavigator.setSize(stage.stageWidth - Config.MENU_MARGIN,stage.height);
    }

    override protected function draw():void
    {
        super.draw();

        _header.setSize(stage.stageWidth,Config.HEADER_HEIGHT);
        _menuNavigator.setSize(stage.stageWidth - Config.MENU_MARGIN,stage.height);
    }
}
}
