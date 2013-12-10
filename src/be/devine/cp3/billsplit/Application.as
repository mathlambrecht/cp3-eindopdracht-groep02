/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit
{
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.navigator.ScreenNavigatorWithHistory;
import be.devine.cp3.billsplit.service.JSONService;
import be.devine.cp3.billsplit.view.Content;
import be.devine.cp3.billsplit.view.pages.Menu;

import feathers.controls.Button;

import feathers.controls.Header;
import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import flash.events.Event;

import starling.display.DisplayObject;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;

public class Application extends Sprite
{
    // Properties
    private var _config:Config;

    private var _appModel:AppModel;
    private var _JSONService:JSONService;

    /*private var _header:Header;*/
    private var _header:Header;
    private var _backButton:Button;
    private var _menuButton:Button;
    private var _content:Content;
    private var _navigator:ScreenNavigatorWithHistory;
    private var _menuNavigator:ScreenNavigator;

    // Constructor
    public function Application()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    // Methods
    private function addedToStageHandler(event:starling.events.Event):void
    {
        this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

        _config = new Config();
        _config.setTheme();

        _appModel = AppModel.getInstance();
        _navigator = new ScreenNavigatorWithHistory();

        createApplication();

        this.stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);
        resizeHandler();

        _JSONService = new JSONService();
        _JSONService.addEventListener(flash.events.Event.COMPLETE, jsonServiceCompleteHandler);
        _JSONService.load();
    }

    private function jsonServiceCompleteHandler(event:flash.events.Event):void
    {
        _appModel.arrBillsVO = _JSONService.arrBillsData;
        _appModel.arrFriendsVO = _JSONService.arrFriendsData;
    }

    private function createApplication():void
    {
        _content = new Content(_navigator);
        addChild(_content);

        _header = new Header();
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

        _header.width = stage.stageWidth;
        _header.height = Config.HEADER_HEIGHT;

        createMenuNavigator();
    }

    private function createMenuNavigator():void
    {
        _menuNavigator = new ScreenNavigator();
        var menu:ScreenNavigatorItem = new ScreenNavigatorItem( new Menu() );
        _menuNavigator.addScreen( Config.MENU , menu );
        addChild(_menuNavigator);
    }

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

    public function resizeHandler(event:ResizeEvent = null):void
    {
        _header.setSize(stage.stageWidth,65);
        _header.setSize(stage.stageWidth, Config.HEADER_HEIGHT);

        _content.y = Config.HEADER_HEIGHT;
        _content.setSize(stage.stageWidth,stage.stageHeight - Config.HEADER_HEIGHT);
    }
}
}
