/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 7/12/13
 * Time: 22:52
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;

import feathers.controls.Button;

import feathers.controls.LayoutGroup;

import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.VerticalLayout;

import starling.display.Quad;

import starling.events.Event;

public class Menu extends Screen{

    // Properties
    private var _appModel:AppModel;

    private var _background:Quad;
    private var _group:LayoutGroup;
    private var _newBillButton:Button;
    private var _oldBillsButton:Button;
    private var _friendsButton:Button;

    private var _arrButtons:Array;

    // Constructor
    public function Menu() 
    {    
        trace('[Menu]');

        _appModel = AppModel.getInstance();
        
        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);

        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;
        _group.layout = layout;

        _background = new Quad(1,1,0xffffff);

        _arrButtons = [];

        _newBillButton = new Button();
        _newBillButton.label = 'New bill';
        _newBillButton.addEventListener(Event.TRIGGERED, clickHandler);
        _arrButtons.push(_newBillButton);

        _oldBillsButton = new Button();
        _oldBillsButton.label = 'Old bills';
        _oldBillsButton.addEventListener(Event.TRIGGERED, clickHandler);
        _arrButtons.push(_oldBillsButton);

        _friendsButton = new Button();
        _friendsButton.label = 'Friends';
        _friendsButton.addEventListener(Event.TRIGGERED, clickHandler);
        _arrButtons.push(_friendsButton);
    }

    // Methods
    private function clickHandler(event:Event):void
    {
        var button:Button = event.currentTarget as Button;
        var nextScreen:String;

        switch (button){
            case _newBillButton:
                nextScreen = Config.NEW_BILL;
                break;
            case _oldBillsButton:
                nextScreen = Config.OLD_BILLS;
                break;
            case _friendsButton:
                nextScreen = Config.FRIENDS;
                break;
        }

        _appModel.currentPage = nextScreen;
    }

    private function groupCreationCompleteHandler(event:Event):void
    {
        draw();
    }

    override protected function initialize():void
    {
        this.addChild(_background);
        _group.addChild(_newBillButton);
        _group.addChild(_oldBillsButton);
        _group.addChild(_friendsButton);
        this.addChild(_group);
    }

    override protected function draw():void
    {
        _background.height = stage.stageHeight;
        _background.width = stage.stageWidth - Config.MENU_MARGIN;

        this.height = stage.stageHeight;
        this.width = stage.stageWidth - Config.MENU_MARGIN;

        _group.width = this.width;
        _group.height = this.height;
        _group.x = 10;
        _group.y = 10;

        for each(var button:Button in _arrButtons){
            button.width = _group.width - 20;
            button.height = 70;
        }
    }
}
}
