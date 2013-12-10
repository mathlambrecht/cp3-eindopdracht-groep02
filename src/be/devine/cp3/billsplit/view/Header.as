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
import be.devine.cp3.billsplit.view.pages.Menu;

import feathers.controls.Button;
import feathers.controls.Header;
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
        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED,clearScreen);

        _menuNavigator = new ScreenNavigator();
        _menuNavigator.addScreen( Config.MENU , new ScreenNavigatorItem( Menu ) );

        _header = new feathers.controls.Header();
        _header.title = "Title";
        addChild(_header);

        _backButton = new Button();
        _backButton.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
        _backButton.addEventListener(starling.events.Event.TRIGGERED, onClickHandler);

        _menuButton = new Button();
        _menuButton.label = 'Menu';
        _menuButton.addEventListener(starling.events.Event.TRIGGERED, onClickHandler);

        _header.leftItems = new <DisplayObject>[ _backButton ];
        _header.rightItems = new <DisplayObject>[ _menuButton ];
    }

    // Methods
    private function onClickHandler(event:starling.events.Event):void
    {
        var button:Button = event.currentTarget as Button;

        switch (button){
            case _backButton:
                _appModel.currentPage = _navigator.goBack(1);
                break;
            case _menuButton:
                    if (_menuNavigator.activeScreenID != Config.MENU)
                    {
                        _menuNavigator.showScreen( Config.MENU );
                    } else
                    {
                        _menuNavigator.clearScreen();
                    }
                break;
        }
    }

    private function clearScreen(event:flash.events.Event):void
    {
        if (_menuNavigator.activeScreenID == Config.MENU) _menuNavigator.clearScreen();
        _backButton.visible = (!(_appModel.currentPage == Config.HOME && _navigator.history.length == 0));
    }

    override protected function initialize():void
    {
        this.addChild(_header);
        this.addChild(_menuNavigator);
    }

    override protected function draw():void
    {
        _header.width = stage.stageWidth;
        _header.height = Config.HEADER_HEIGHT;

        _menuNavigator.height = stage.height;
        _menuNavigator.width = stage.stageWidth - Config.MENU_MARGIN;
    }
}
}
