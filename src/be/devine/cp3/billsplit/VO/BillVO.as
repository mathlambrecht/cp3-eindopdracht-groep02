package be.devine.cp3.billsplit.vo
{
public class BillVO
{
    public var id:uint;
    public var title:String;
    public var datetime:Date;
    public var arrFriends:Array;
    public var arrItems:Array;
    public var totalPrice:Number;
    public var splitMethod:String;
    public var arrFriendPercentage:String;
    public var arrFriendItems:String;

    public function BillVO(){}
}
}
