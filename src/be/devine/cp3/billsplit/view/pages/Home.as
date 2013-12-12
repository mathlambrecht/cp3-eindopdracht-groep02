package be.devine.cp3.billsplit.view.pages
{
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.vo.BillVO;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import starling.events.Event;

public class Home extends Screen
{
    // Properties
    private var _appModel:AppModel;

    private var _oldBillsButton:Button;
    private var _newBillButton:Button;
    private var _buttonGroup:LayoutGroup;

    // Contructor
    public function Home()
    {
        trace('[Home]');

        _appModel = AppModel.getInstance();
        createHome();
    }

    // Methods
    private function createHome():void
    {
        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);

        var layout:HorizontalLayout = new HorizontalLayout();
        layout.gap = 40;
        _buttonGroup.layout = layout;

        _oldBillsButton = new Button();
        _oldBillsButton.label = 'Old bills';
        _oldBillsButton.addEventListener(Event.TRIGGERED, clickHandler);

        _newBillButton = new Button();
        _newBillButton.label = 'New bill';
        _newBillButton.addEventListener(Event.TRIGGERED, clickHandler);
    }

    private function clickHandler(event:Event):void
    {
        var button:Button = event.currentTarget as Button;
        var nextScreen:String;

        switch (button)
        {
            case _oldBillsButton:
                    nextScreen = Config.OLD_BILLS;
                    break;

            case _newBillButton:
                    nextScreen = Config.NEW_BILL;
                    break;
        }

        _appModel.currentPage = nextScreen;
    }

    override protected function initialize():void
    {
        _buttonGroup.addChild(_oldBillsButton);
        _buttonGroup.addChild(_newBillButton);
        this.addChild(_buttonGroup);
    }

    private function buttonGroupCreationCompleteHandler(event:Event):void
    {
        draw();
    }

    override protected function draw():void
    {
        _buttonGroup.y = this.height - _buttonGroup.height - 80;
        _buttonGroup.x = this.width/2 - _buttonGroup.width/2;
    }
}
}
