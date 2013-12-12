package be.devine.cp3.billsplit.view.components
{

import feathers.controls.NumericStepper;
import feathers.controls.renderers.DefaultListItemRenderer;

public class CustomLayoutGroupItemRenderer extends DefaultListItemRenderer
{
    private var _numericStepper:NumericStepper;

    public function CustomLayoutGroupItemRenderer()
    {
        _numericStepper = new NumericStepper();
    }

    override protected function initialize():void
    {
        super.initialize();
        addChild(_numericStepper);
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
    }


    override protected function layoutContent():void
    {
        super.layoutContent();

        _numericStepper.height = this.height;
        _numericStepper.x = 200;
    }

    public function get numericStepper():NumericStepper
    {
        return _numericStepper;
    }

    public function set numericStepper(value:NumericStepper):void
    {
        _numericStepper = value;
    }
}
}
