{
  "spriteId": {
    "name": "ssy_areaRelay",
    "path": "sprites/ssy_areaRelay/ssy_areaRelay.yy",
  },
  "solid": false,
  "visible": false,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "o_livelyLogicRelay_QuestFlag",
    "path": "objects/o_livelyLogicRelay_QuestFlag/o_livelyLogicRelay_QuestFlag.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 0,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"parent":{"name":"o_livelyTriggerRelay_QuestFlag","path":"objects/o_livelyTriggerRelay_QuestFlag/o_livelyTriggerRelay_QuestFlag.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,"parent":{"name":"o_livelyTriggerRelay_QuestFlag","path":"objects/o_livelyTriggerRelay_QuestFlag/o_livelyTriggerRelay_QuestFlag.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":6,"value":"kTriggerByPlayer","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[
        "kTriggerByPlayer",
        "kTriggerByParty",
        "kTriggerByEnemy",
        "kTriggerByProjectile",
      ],"multiselect":false,"filters":[
        "GMTileSet",
        "GMSprite",
        "GMSound",
        "GMPath",
        "GMScript",
        "GMShader",
        "GMFont",
        "GMTimeLine",
        "GMObject",
        "GMRoom",
      ],"resourceVersion":"1.0","name":"m_triggerBy","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"2.0","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":null,"multiselect":false,"filters":[
        "GMTileSet",
        "GMSprite",
        "GMSound",
        "GMPath",
        "GMScript",
        "GMShader",
        "GMFont",
        "GMTimeLine",
        "GMObject",
        "GMRoom",
      ],"resourceVersion":"1.0","name":"m_retriggerDelay","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [],
  "parent": {
    "name": "Trigger",
    "path": "folders/Objects/Gameplay/Lively/Trigger.yy",
  },
  "resourceVersion": "1.0",
  "name": "o_livelyTriggerRelay_QuestFlag",
  "tags": [],
  "resourceType": "GMObject",
}