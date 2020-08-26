/// @description OnSchedule

var bFlagsPassed = questGetValue(kQidMithraEscape) >= 30
				&& questGetValue(kQidFoolsTower) >= 30;
var currentHour = timeofdayGetHour();

if (room == rm_oasis_town)
{
	if (bFlagsPassed)
	{
		if (timeofdayGetDay() % 2 == 0)
		{
			m_schedule = [
				[ 6, kScheduleGoalMoveTo, [0, 0], inst_35FAFA6B, [444, -32], null],
				[17, kScheduleGoalLeaveTo, [444, -32], null]
			];
		}
		else
		{
			m_schedule = [[0, kScheduleGoalGone]]; // Empty schedule. Does not exist.
		}
	}
	else
	{
		m_schedule = [[0, kScheduleGoalGone]]; // Empty schedule. Does not exist.
	}
}
else if (room == rm_mithra)
{
	if (bFlagsPassed)
	{
		if (timeofdayGetDay() % 2 == 0)
		{
			m_schedule = [[0, kScheduleGoalGone]];
		}
		else
		{
			m_schedule = [
				[ 1, kScheduleGoalLeaveTo, [840, -32], null],
				[ 5, kScheduleGoalMoveTo, [], inst_4EFED7E8, [840, -32], null],
				[18, kScheduleGoalMoveTo, [], pn_inside_tavern_4A29128B],
			];
		}
	}
	else
	{
		m_schedule = [
			[ 1, kScheduleGoalLeaveTo, [840, -32], null],
			[ 5, kScheduleGoalMoveTo, [], inst_4EFED7E8, [840, -32], null],
			[18, kScheduleGoalMoveTo, [], pn_inside_tavern_4A29128B],
		];
	}
}

event_inherited();