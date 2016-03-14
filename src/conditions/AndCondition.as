package conditions
{
	/**
	 * AndCondition.
	 *
	 */
	public class AndCondition implements ICondition
	{

		private var _conditionsVec: Vector.<ICondition>;
		private var _failReason:String = "";

		public function AndCondition()
		{
		}


		public function check(user:UserModel):Boolean
		{
			var result:Boolean = true;
			_failReason = "";
			for (var i:int = 0; i < _conditionsVec.length; i++)
			{
				var condition:ICondition = _conditionsVec[i];
				if (!condition.check(user))
				{
					result = false;
					_failReason += condition.failReason + "\n";
				}
			}

			return result;
		}

		public function get failReason():String
		{
			return _failReason;
		}

		private var _dataXML:XML;
		public function modify(data:XML):void
		{
			_dataXML = data;
			_conditionsVec = new <ICondition>[];
			for each (var item:XML in _dataXML.elements())
			{
				var result:Vector.<ICondition> = FabricConditions.parse(item);
				_conditionsVec = _conditionsVec.concat(result);
			}
		}
	}
}