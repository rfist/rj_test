package
{
	import flash.utils.Dictionary;

	import vo.UnitVO;

	public class UserModel
	{
		private var _level: int;
		private var _units: Dictionary;
		private var _updates: Array;
		public function UserModel()
		{
		}
		
		public function modify(dataXML :XML): void
		{
			_units = new Dictionary();
			_updates = [];
			_level = dataXML[0].@level;

			//TODO: добавить проверку, есть ли данные поля в загруженном XML
			const UNITS_COUNT: int = dataXML[0].units[0].unit.length();
			const UPGRADES_COUNT: int = dataXML[0].processes[0].upgrade_unit.length(); 
			var i:int;
			for (i = 0; i < UNITS_COUNT; i++)
			{
				var unit:UnitVO = new UnitVO(dataXML[0].units[0].unit[i]);	
				_units[unit.type] = unit;
			}
			for (i = 0; i < UPGRADES_COUNT; i++)
			{
				var upgradeName:String = dataXML[0].processes[0].upgrade_unit[i].@type;
				_updates.push(upgradeName);
			}
		}

		public function get level():int
		{
			return _level;
		}

		public function get units():Dictionary
		{
			return _units;
		}

		public function get updates():Array
		{
			return _updates;
		}
	}
}