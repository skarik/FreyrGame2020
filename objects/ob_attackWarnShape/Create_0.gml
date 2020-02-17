/// @description Create params

event_inherited();

#macro kAttackWarnTypeAura 0
#macro kAttackWarnTypeTech 1

#macro kAttackWarnMagicVoid 0
#macro kAttackWarnMagicEarth 1

m_type = kAttackWarnTypeAura;
m_magic = kAttackWarnMagicVoid;
m_draw_text = true;
m_source = null;
// Alpha controlled with image_alpha
image_alpha = 0.0;

m_vertices = array_create(0);
m_indices = array_create(0);
m_primitive = pr_trianglelist;

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_color();
vertexFormat = vertex_format_end();
mesh = vertex_create_buffer();
mesh_ready = false;
text_x = 0;
text_y = 0;