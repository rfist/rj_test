package conditions
{
	import vo.UnitVO;

	/**
	 * BaseCondition.
	 *
	 */
	public class BaseCondition implements ICondition
	{
		private static const USER_LEVEL_GT:String = "user_level_gt";
		private static const UNIT_LEVEL_EQ:String = "unit_level_eq";
		private static const UNIT_UPGRADE_STARTED:String = "unit_upgrade_started";
		private var _isAcceptable:Boolean;

		public function BaseCondition(acceptable: Boolean = true)
		{
			_isAcceptable = acceptable;
		}
		private var _dataXML:XML;
		public function modify(data:XML):void
		{
			_dataXML = data;
		}

		public function get type(): String
		{
			return _dataXML.name();
		}

		private var _failReason:String = "Unknown";
		public function check(user:UserModel):Boolean
		{
			var result:Boolean = false;
			_failReason = "Unknown";
			switch (type)
			{
				case USER_LEVEL_GT:
					if (_dataXML.@level <= user.level)
					{
						result = true;
					}
					_failReason = (_isAcceptable ? "Уровень игрока должен быть больше или равен ": "Уровень игрока должен быть меньше ") + _dataXML.@level;
					break;


				case UNIT_LEVEL_EQ:
					var unitLevel:int = _dataXML.@level;
					var unitType:String = _dataXML.@type;
					if (user.units.hasOwnProperty(unitType))
					{
						if((user.units[unitType] as UnitVO).level >= unitLevel)
						{
							result = true;
						}
						_failReason = "Уровень юнита " + unitType + (_isAcceptable ? "": " НЕ") + " должен быть равен " + unitLevel;
					}
					else
					{
						_failReason = "У игрока еще нет юнита " + unitType;
					}
					break;

				case UNIT_UPGRADE_STARTED:
					var upgradeName:String = _dataXML.@type;
					result = user.updates.indexOf(upgradeName) > -1;
					_failReason = "Процесс улучшения " + upgradeName + (_isAcceptable ? " еще не запущен": " не должен быть запущен");
					break;

				default:
					_failReason = "Неизвестное условие";
			}

			if (_isAcceptable)
			{
				return result;
			}
			else
			{
				return !result;
			}
		}

		public function get failReason():String
		{
			return _failReason;
		}
	}
}