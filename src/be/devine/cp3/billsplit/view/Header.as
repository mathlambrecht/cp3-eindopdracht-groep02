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

import feathers.controls.Button;
import feathers.controls.Screen;

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

    private var _background:Quad;
    private var _textField:TextField;
    private var _backButton:Button;

    // Constructor
    public function Header(navigator:ScreenNavigatorWithHistory)
    {
        trace('[Header]');

        _navigator = navigator;
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED,showHideBackButton);
        createHeader();
    }

    // Methods
    private function createHeader():void
    {
        _background = new Quad(1,1,0x000000);
        addChild(_background);

        _textField = new TextField(200,65,'Title','Verdana',18,0xffffff);
        _textField.hAlign = HAlign.CENTER;
        _textField.vAlign = VAlign.CENTER;
        addChild(_textField);

        // todo: positionering (button group?)
        _backButton = new Button();
        _backButton.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
        _backButton.addEventListener(starling.events.Event.TRIGGERED, onClickHandler);
        this.addChild(_backButton);
    }

    private function showHideBackButton(event:flash.events.Event):void
    {
        _backButton.visible = (!(_appModel.currentPage == Config.HOME && _navigator.history.length == 0));
    }

    override public function setSize(width:Number,height:Number):void
    {
        super.setSize(width,height);

        _background.width = width;
        _background.height = height;

        _textField.width = width;
        _textField.height = height;
    }

    private function onClickHandler(event:starling.events.Event):void {
        trace('[Header] Back button clicked');

        _appModel.currentPage = _navigator.goBack(1);
    }
}
}
