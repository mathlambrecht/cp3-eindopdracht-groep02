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
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import flash.events.Event;

import starling.display.Quad;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Header extends Screen {

    // Properties
    private var _appModel:AppModel;
    private var _navigator:ScreenNavigatorWithHistory;

    private var _group:LayoutGroup;
    private var _background:Quad;
    private var _textField:TextField;
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

        createMenuNavigator();
        createHeader();
    }

    // Methods
    private function createMenuNavigator():void
    {
        _menuNavigator = new ScreenNavigator();
        var menu:ScreenNavigatorItem = new ScreenNavigatorItem( new Menu() );

        _menuNavigator.addScreen( Config.MENU , menu );
    }

    private function createHeader():void
    {
        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);

        var layout:HorizontalLayout = new HorizontalLayout();
        layout.gap = 10;
        _group.layout = layout;

        _background = new Quad(1,1,0x000000);

        _textField = new TextField(200,65,'Title','Verdana',18,0xffffff);
        _textField.hAlign = HAlign.CENTER;
        _textField.vAlign = VAlign.CENTER;

        _backButton = new Button();
        _backButton.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
        _backButton.addEventListener(starling.events.Event.TRIGGERED, onClickHandler);

        _menuButton = new Button();
        _menuButton.label = 'Menu';
        _menuButton.addEventListener(starling.events.Event.TRIGGERED, onClickHandler);
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
        trace('clear');
        if (_menuNavigator.activeScreenID == Config.MENU) _menuNavigator.clearScreen();
        _backButton.visible = (!(_appModel.currentPage == Config.HOME && _navigator.history.length == 0));
    }

    /*

    override public function setSize(width:Number,height:Number):void
    {
        super.setSize(width,height);

        _background.width = width;
        _background.height = height;

        _textField.width = width;
        _textField.height = height;
    }

    */

    private function groupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function initialize():void
    {
        this.addChild(_background);
        _group.addChild(_textField);
        _group.addChild(_backButton);
        _group.addChild(_menuButton);
        this.addChild(_group);
        addChild(_menuNavigator);
    }

    override protected function draw():void
    {
    /*
        _background.width = stage.stageWidth;
        _background.height = Config.HEADER_HEIGHT;*/

        _group.width = stage.stageWidth;
        _group.height = Config.HEADER_HEIGHT;
/*
        _textField.width = _group.width;
        _textField.height = Config.HEADER_HEIGHT;
*/
        _backButton.x = 10;
        _backButton.y = Config.HEADER_HEIGHT/2 - _backButton.height/2;

        _menuButton.x = stage.stageWidth - _menuButton.width - 10;
        _menuButton.y = Config.HEADER_HEIGHT/2 - _menuButton.height/2;
    }
}
}
