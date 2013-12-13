package be.devine.cp3.billsplit.utils
{
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.vo.FriendPercentageVO;

public class MathUtilities
{

    public static function divideEqual(splitCount):Number
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
}
}
