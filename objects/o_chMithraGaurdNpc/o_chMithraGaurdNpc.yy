{
  "spriteId": {
    "name": "s_charMithraGaurd1_Stand",
    "path": "sprites/s_charMithraGaurd1_Stand/s_charMithraGaurd1_Stand.yy",
  },
  "solid": false,
  "visible": true,
  "spriteMaskId": {
    "name": "sc_16x16char",
    "path": "sprites/sc_16x16char/sc_16x16char.yy",
  },
  "persistent": false,
  "parentObjectId": {
    "name": "ob_characterGroundInteractable",
    "path": "objects/ob_characterGroundInteractable/ob_characterGroundInteractable.yy",
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
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"parent":{"name":"o_chMithraGaurdNpc","path":"objects/o_chMithraGaurdNpc/o_chMithraGaurdNpc.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":2,"collisionObjectId":null,"parent":{"name":"o_chMithraGaurdNpc","path":"objects/o_chMithraGaurdNpc/o_chMithraGaurdNpc.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,"parent":{"name":"o_chMithraGaurdNpc","path":"objects/o_chMithraGaurdNpc/o_chMithraGaurdNpc.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":5,"value":"noone","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":null,"multiselect":false,"filters":[
        "GMObject",
      ],"resourceVersion":"1.0","name":"m_patrolPathStart","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":3,"value":"0","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":null,"multiselect":false,"filters":[
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
      ],"resourceVersion":"1.0","name":"m_ai_disableAggression","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [
    {"propertyId":{"name":"m_interactionFile","path":"objects/ob_characterGroundInteractable/ob_characterGroundInteractable.yy",},"objectId":{"name":"ob_characterGroundInteractable","path":"objects/ob_characterGroundInteractable/ob_characterGroundInteractable.yy",},"value":"","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"m_name","path":"objects/ob_characterGroundInteractable/ob_characterGroundInteractable.yy",},"objectId":{"name":"ob_characterGroundInteractable","path":"objects/ob_characterGroundInteractable/ob_characterGroundInteractable.yy",},"value":"Mithra Guard","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Characters",
    "path": "folders/Objects/Characters.yy",
  },
  "resourceVersion": "1.0",
  "name": "o_chMithraGaurdNpc",
  "tags": [],
  "resourceType": "GMObject",
}