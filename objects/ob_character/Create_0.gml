/// @description Default teams & values

enemyInfoOnCharacterCreate();

m_team = kTeamNone;
m_bloodType = kBloodRed;
m_dieInsteadOfKO = false;
m_uiwantsHealthShown = false;
m_uiwantsStaminaShown = false;
m_standingHeight = 32;

m_lastDamage = 0;
m_lastDamageSource = null;

m_isPlayer = false;
m_isFollower = false;
m_isKOed = false;
m_isDead = false;
m_isStunned = false;
m_stunTimer = 0.0;

// Each character has a set of stats
stats = inew(o_stats);

characterMotionInit();

// Some common values for damage stuff

isBlocking = false;
isDashing = false;
isEthereal = false;
isPassthru = false;

// Init depth setup
depthInit();

// Other state
isHidden = false;

// Mark as initialized
m_initialized = true;