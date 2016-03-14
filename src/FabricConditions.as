package {
	import conditions.AndCondition;
	import conditions.BaseCondition;
	import conditions.ICondition;
	import conditions.OrCondition;

	import mx.controls.Alert;

	/**
	 * FabricConditions.
	 *
	 */
	public class FabricConditions
	{
		public static var AND_CONDITION:String = "and";
		public static var OR_CONDITION:String = "or";
		public static var NOT_CONDITION:String = "not";

		public function FabricConditions()
		{

		}

		private static function generate(item: XML, acceptable: Boolean = true): ICondition
		{
			var name:String = item.name();

			var condition:ICondition;
			switch (name)
			{
				case OR_CONDITION:
					if (!acceptable)
					{
						showErrorIncorrectNOT();
					}
					condition = new OrCondition();
					break;
				case AND_CONDITION:
					if (!acceptable)
					{
						showErrorIncorrectNOT();
					}
					condition = new AndCondition();
					break;
				default:
					condition = new BaseCondition(acceptable);
					break;
			}
			condition.modify(item);
			return condition;
		}

		private static function showErrorIncorrectNOT(): void
		{
			Alert.show("Условие NOT должно быть только у базовых условий", 'Ошибка!', Alert.OK);
		}

		public static function parse(item: XML): Vector.<ICondition>
		{
			var result:Vector.<ICondition> = new <ICondition>[];
			var name:String = item.name();
			if (name == NOT_CONDITION)
			{
				for each (var item:XML in item.elements())
				{
					result.push(generate(item, false));
				}
			}
			else
			{
				result.push(generate(item));
			}

			return result;
		}

	}
}