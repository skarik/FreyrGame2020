/// @description delet
if (!iexists(m_target)) {
	idelete(this);
	exit;
}
	
depth = m_target.depth + 1;
x = m_target.x;
y = m_target.y;