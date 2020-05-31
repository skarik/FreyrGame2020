/// @description check destruction

alarm[1] = 20;

if (!audio_is_playing(m_instance))
{
    idelete(this);
}
