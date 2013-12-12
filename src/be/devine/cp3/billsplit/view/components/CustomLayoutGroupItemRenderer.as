package be.devine.cp3.billsplit.view.components
{
import feathers.controls.NumericStepper;
import feathers.controls.renderers.LayoutGroupListItemRenderer;

public class CustomLayoutGroupItemRenderer extends LayoutGroupListItemRenderer
{
    private var _numericStepper:NumericStepper;

    public function CustomLayoutGroupItemRenderer(){}

    override protected function initialize():void
    {
        _numericStepper = new NumericStepper();
        addChild(_numericStepper);
    }

    override protected function commitData():void
    {
        if(this._data)
        {
            _numericStepper.minimum = 0;
            _numericStepper.maximum = 100;
            _numericStepper.value = this._data.value;
        }
    }
}
}
