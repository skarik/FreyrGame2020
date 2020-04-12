/// @description Default teams & values

m_team = kTeamNone;
m_bloodType = kBloodRed;
m_uiwantsHealthShown = false;
m_uiwantsStaminaShown = false;
m_standingHeight = 32;

m_lastDamage = 0;
m_lastDamageSource = null;

m_isPlayer = false;
m_isFollower = false;
m_isDead = false;
m_isStunned = false;
m_stunTimer = 0.0;

// Each character has a set of stats
stats = new(o_stats);

characterMotionInit();

// Some common values for damage stuff

isBlocking = false;
isDashing = false;
isEthereal = false;
isPassthru = false;

// Init depth setup
depthInit();

// Mark as initialized
m_initialized = true;