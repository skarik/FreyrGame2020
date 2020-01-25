/// @description Glitch base

depth = -8999;
persistent = true;

m_glitchBaseBuffer = null;
m_glitchDeltaBuffer = null;
m_glitchBaseX = 0;
m_glitchBaseY = 0;

m_glitchFader = 0.0;


uSceneBOffset = shader_get_uniform(sh_generateDifferences, "uSceneBOffset");
samplerSceneB = shader_get_sampler_index(sh_generateDifferences, "samplerSceneB");