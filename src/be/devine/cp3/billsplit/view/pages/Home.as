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

    private var _buttonGroup:LayoutGroup;

    private var _oldBillsButton:Button;
    private var _newBillButton:Button;

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
        _buttonGroup.layout = new HorizontalLayout();

        _oldBillsButton = new Button();
        _oldBillsButton.label = 'Old bills';
        _oldBillsButton.addEventListener(Event.TRIGGERED, oldBillsButtonTriggeredHandler);

        _newBillButton = new Button();
        _newBillButton.label = 'New bill';
        _newBillButton.addEventListener(Event.TRIGGERED, newBillButtonTriggeredHandler);
    }

    private function newBillButtonTriggeredHandler(event:Event):void
    {
        _appModel.isNewBill = true;

        _appModel.currentBillVO = new BillVO();
        _appModel.currentPage = Config.NEW_BILL;
    }

    private function oldBillsButtonTriggeredHandler(event:Event):void
    {

        _appModel.currentPage = Config.OLD_BILLS;
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
        super.draw();

        _oldBillsButton.width = this.width/2;
        _oldBillsButton.height = this.width/2;

        _newBillButton.width = this.width/2;
        _newBillButton.height = this.width/2;

        _buttonGroup.y = this.height - _buttonGroup.height;
    }
}
}
