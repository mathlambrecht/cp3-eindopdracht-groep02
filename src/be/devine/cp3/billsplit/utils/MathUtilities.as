package be.devine.cp3.billsplit.utils
{
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.vo.FriendPercentageVO;
import be.devine.cp3.billsplit.vo.ItemVO;

public class MathUtilities
{
    public static function divideEqual(splitCount:Number):Number
    {
        var result:Number = 100/splitCount;
        return result;
    }

    public static function calculatePercentageLeft():Number
    {
        var billModel:BillModel = BillModel.getInstance();
        var result:Number = 100;

        for each(var friendPercentageVO:FriendPercentageVO in billModel.arrFriendPercentage)
        {
            result -= friendPercentageVO.percentage;
        }

        return result;
    }

    public static function calculatePercentageByFriend(percentage:Number):Number
    {
        var billModel:BillModel = BillModel.getInstance();

        var result:Number;

        result = billModel.totalPrice * (percentage/100);

        return MathUtilities.roundDecimal(result);
    }

    public static function calculateTotalPrice(arrItems:Array):Number
    {
        var totalPrice:Number = 0;

        for each(var itemVO:ItemVO in arrItems)
        {
            totalPrice += itemVO.value * itemVO.amount;
        }

        return roundDecimal(totalPrice);
    }

    public static function roundDecimal(number:Number):Number
    {
        return Math.round(number*100)/100;
    }
}
}
