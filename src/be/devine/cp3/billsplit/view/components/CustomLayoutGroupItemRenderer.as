package be.devine.cp3.billsplit.view.components
{

import be.devine.cp3.billsplit.model.BillModel;

import feathers.controls.NumericStepper;
import feathers.controls.renderers.DefaultListItemRenderer;

import flash.events.Event;

import starling.events.Event;

public class CustomLayoutGroupItemRenderer extends DefaultListItemRenderer
{
    private var _billModel:BillModel;
    private var _numericStepper:NumericStepper;

    public function CustomLayoutGroupItemRenderer()
    {
        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.PERCENTAGE_LEFT_CHANGED, percentageLeftChangedHandler);

        _numericStepper = new NumericStepper();
        _numericStepper.addEventListener(starling.events.Event.CHANGE, numericStepperChangeHandler);
    }

    private function percentageLeftChangedHandler(event:flash.events.Event):void
    {
        if(_billModel.percentageLeft > 0)
        {
            _numericStepper.minimum = 0;
            _numericStepper.maximum = 100;
        }
        else if(_billModel.percentageLeft == 0)
        {
            _numericStepper.maximum = _numericStepper.value;
        }
        else if(_billModel.percentageLeft == 100)
        {
            _numericStepper.minimum = _numericStepper.value;
        }
    }

    private function numericStepperChangeHandler(event:starling.events.Event):void
    {
        this._data.value = this._numericStepper.value;

        dispatchEvent(new starling.events.Event(starling.events.Event.CHANGE));
    }

    override protected function commitData():void
    {
        super.commitData();

        _numericStepper.minimum = 0;
        _numericStepper.maximum = 100;
        _numericStepper.step = 1;

        if (this._data)
        {
            _numericStepper.value = this._data.value;
        }
        else
        {
            _numericStepper.value = 0;
        }

        percentageLeftChangedHandler(null);
    }

    override protected function initialize():void
    {
        super.initialize();
        addChild(_numericStepper);
    }

    override protected function layoutContent():void
    {
        super.layoutContent();

        _numericStepper.height = this.height;
        _numericStepper.x = 200;
    }
}
}
