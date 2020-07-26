/// @description On Trigger
#macro kObjectAction_Delete 0

if (m_objectAction == kObjectAction_Delete)
{
	idelete_delay(m_targetObject, 0.0);
}
